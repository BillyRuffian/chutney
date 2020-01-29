# gherkin utilities
module Chutney
  # base class for all linters
  class Linter
    attr_accessor :issues
    attr_reader :filename
    attr_reader :configuration
  
    Lint = Struct.new(:message, :gherkin_type, :location, :feature, :scenario, :step, keyword_init: true)

    def self.descendants
      ObjectSpace.each_object(::Class).select { |klass| klass < self }
    end

    def initialize(filename, content, configuration)
      @content = content
      @filename = filename
      @issues = []
      @configuration = configuration
      language = @content.dig(:feature, :language) || 'en'
      @dialect = Gherkin::Dialect.for(language)
    end

    def lint
      raise 'not implemented'
    end
    
    def and_word?(word)
      @dialect.and_keywords.include?(word)
    end
    
    def background_word?(word)
      @dialect.background_keywords.include?(word)
    end
    
    def but_word?(word)
      @dialect.but_keywords.include?(word)
    end
    
    def examples_word?(word)
      @dialect.example_keywords.include?(word)
    end
    
    def feature_word?(word)
      @dialect.feature_keywords.include?(word)
    end
    
    def given_word?(word)
      @dialect.given_keywords.include?(word)
    end
    
    def scenario_outline_word?(word)
      @dialect.scenario_outline_keywords.include?(word)
    end
    
    def then_word?(word)
      @dialect.then_keywords.include?(word)
    end
    
    def when_word?(word)
      @dialect.when_keywords.include?(word)
    end
  
    def tags_for(element)
      return [] unless element.include? :tags

      element[:tags].map { |tag| tag[:name][1..-1] }
    end
    
    def add_issue(message, feature, scenario = nil, step = nil)
      issues << Lint.new(
        message: message,
        gherkin_type: type(feature, scenario, step),
        location: location(feature, scenario, step),
        feature: feature[:name],
        scenario: scenario ? scenario[:name] : nil,
        step: step ? step[:text] : nil
      ).to_h
    end
    
    def location(feature, scenario, step)
      if step
        step[:location]
      else
        scenario ? scenario[:location] : feature[:location]
      end
    end
    
    def type(_feature, scenario, step)
      if step
        :step
      else
        scenario ? :scenario : :feature
      end
    end

    def feature
      if block_given?
        yield(@content[:feature]) if @content[:feature]
      else
        @content[:feature]
      end
    end
    
    def elements
      if block_given? 
        feature[:children].each do |child|
          next if off_switch?(child)
        
          yield(feature, child)
        end
      else
        feature[:children]
      end
    end
    
    def off_switch?(element = feature)
      #       thing = element[:tags]
      #               .then { |tags| tags || [] }
      #               .filter { |tag| tag[:type] == :Tag }
      #               .filter { |tag| tag[:name] == "@disable#{linter_name}" }
      #               .count
      #               .positive?
      #       puts "#{linter_name} #{element[:type]} #{thing}"
      off_switch = element[:tags]
                   .then { |tags| tags || [] }
                   .filter { |tag| tag[:type] == :Tag }
                   .filter { |tag| tag[:name] == "@disable#{linter_name}" }
                   .count
                   .positive?
      off_switch ||= off_switch?(feature) unless element == feature
      off_switch
    end
    
    def background
      if block_given?
        elements do |feature, child|
          next unless child[:type] == :Background
          
          yield(feature, child)
        end
      else
        elements.filter { |child| child[:type] == :Background }
      end
    end
    
    def scenarios
      if block_given?
        elements do |feature, child|
          next unless %i[ScenarioOutline Scenario].include? child[:type]
        
          yield(feature, child)
        end
      else
        elements.filter { |child| %i[ScenarioOutline Scenario].include? child[:type] }
      end
    end
    
    def filled_scenarios
      if block_given?
        scenarios do |feature, scenario|
          next unless scenario.include? :steps
          next if scenario[:steps].empty?
        
          yield(feature, scenario)
        end
      else
        scenarios.filter { |s| !s[:steps].empty? }
      end
    end
    
    def steps
      elements do |feature, child|
        next unless child.include? :steps
        
        child[:steps].each { |step| yield(feature, child, step) }
      end
    end

    def self.linter_name
      name.split('::').last
    end
    
    def linter_name
      self.class.linter_name
    end

    def render_step(step)
      value = "#{step[:keyword]}#{step[:text]}"
      value += render_step_argument step[:argument] if step.include? :argument
      value
    end
    
    def render_step_argument(argument)
      return "\n#{argument[:content]}" if argument[:type] == :DocString
      
      result = argument[:rows].map do |row|
        "|#{row[:cells].map { |cell| cell[:value] }.join '|'}|"
      end.join "\n"
      "\n#{result}"
    end
  end
end
