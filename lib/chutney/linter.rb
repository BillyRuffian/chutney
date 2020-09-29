# frozen_string_literal: true

# gherkin utilities

module Chutney
  # base class for all linters
  class Linter
    attr_accessor :issues
    attr_reader :filename, :configuration

    Lint = Struct.new(:message, :gherkin_type, :location, :feature, :scenario, :step, keyword_init: true)

    def self.descendants
      ObjectSpace.each_object(::Class).select { |klass| klass < self }
    end

    def initialize(filename, content, configuration)
      @content = content
      @filename = filename
      @issues = []
      @configuration = configuration
      #       language = @content.dig(:feature, :language) || 'en'
      #       @dialect = Gherkin::Dialect.for(language)
    end

    def lint
      raise 'not implemented'
    end

    def and_word?(word)
      dialect_word(:and).include?(word)
    end

    def background_word?(word)
      dialect_word(:background).include?(word)
    end

    def but_word?(word)
      dialect_word(:but).include?(word)
    end

    def examples_word?(word)
      dialect_word(:examples).include?(word)
    end

    def feature_word?(word)
      dialect_word(:feature).include?(word)
    end

    def given_word?(word)
      dialect_word(:given).include?(word)
    end

    def scenario_outline_word?(word)
      dialect_word(:scenarioOutline).include?(word)
    end

    def then_word?(word)
      dialect_word(:then).include?(word)
    end

    def when_word?(word)
      dialect_word(:when).include?(word)
    end

    def dialect_word(word)
      CukeModeler::Parsing.dialects[dialect][word.to_s].map(&:strip)
    end

    def dialect
      @content.feature&.parsing_data&.dig(:language) || 'en'
    end

    def tags_for(element)
      element.tags.map { |tag| tag.name[1..-1] }
    end

    def add_issue(message, feature = nil, scenario = nil, item = nil)
      issues << Lint.new(
        message: message,
        gherkin_type: type(feature, scenario, item),
        location: location(feature, scenario, item),
        feature: feature&.name,
        scenario: scenario&.name,
        step: item&.parsing_data&.dig(:name)
      ).to_h
    end

    def location(feature, scenario, step)
      if step
        step.parsing_data[:location]
      elsif scenario
        scenario.parsing_data.dig(:scenario, :location) || scenario.parsing_data.dig(:background, :location)
      else
        feature ? feature.parsing_data[:location] : { line: 0, column: 0 }
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
        yield(@content.feature) if @content.feature
      else
        @content.feature
      end
    end

    def elements
      return [] unless feature

      if block_given?
        feature.children.each do |child|
          next if off_switch?(child)

          yield(feature, child)
        end
      else
        feature.children
      end
    end

    def off_switch?(element = feature)
      # require 'pry'; binding.pry
      off_switch = element.tags
                          .map(&:name)
                          .then { |tags| tags || [] }
                          .filter { |tag_name| tag_name == "@disable#{linter_name}" }
                          .count
                          .positive?
      off_switch ||= off_switch?(feature) unless element == feature
      off_switch
    end

    def background
      return unless feature&.background
      return if off_switch?(feature)

      if block_given?
        yield(feature, feature.background)
      else
        feature.background
      end
    end

    def scenarios
      if block_given?
        feature&.tests&.each do |test|
          next if off_switch?(test)

          yield(feature, test)
        end

      else
        feature&.tests
      end
    end

    def filled_scenarios
      if block_given?
        scenarios do |feature, scenario|
          next if scenario.steps.empty?

          yield(feature, scenario)
        end
      else
        scenarios ? scenarios.filter { |s| !s.steps.empty? } : []
      end
    end

    def steps
      feature&.tests&.each do |test|
        next if off_switch?(test)

        test.steps.each do |step|
          yield(feature, test, step)
        end
      end
    end

    def self.linter_name
      name.split('::').last
    end

    def linter_name
      self.class.linter_name
    end

    def render_step(step)
      value = "#{step.keyword} #{step.text}"
      value += render_step_argument(step.block) if step.block
      value
    end

    def render_step_argument(argument)
      return "\n#{argument.content}" if argument.is_a?(CukeModeler::DocString)

      result = argument.rows.map do |row|
        "|#{row.cells.map(&:value).join '|'}|"
      end.join "\n"
      "\n#{result}"
    end
  end
end
