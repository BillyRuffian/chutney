module Chutney
  # service class to lint for using background
  class UseBackground < Linter
    def lint
      return unless filled_scenarios.count > 1

      givens = gather_givens
      return if givens.nil?
      return if givens.length <= 1
      return if givens.uniq.length > 1

      add_issue(I18n.t('linters.use_background', step: givens.uniq.first), feature)
    end

    def gather_givens
      return unless feature.include? :children
      
      has_non_given_step = false
      feature[:children].each do |scenario|
        next unless scenario.include? :steps
        next if scenario[:steps].empty?
        
        has_non_given_step = true unless given_word?(scenario[:steps].first[:keyword])
      end
      return if has_non_given_step

      result = []
      expanded_steps { |given| result.push given }
      result
    end

    def expanded_steps
      feature[:children].each do |scenario|
        next unless scenario[:type] != :Background
        next unless scenario.include? :steps
        next if scenario[:steps].empty?
        
        prototypes = [render_step(scenario[:steps].first)]
        prototypes = expand_examples(scenario[:examples], prototypes) if scenario.key? :examples
        prototypes.each { |prototype| yield prototype }
      end
    end

    def expand_examples(examples, prototypes)
      examples.each do |example|
        prototypes = prototypes.map { |prototype| expand_outlines(prototype, example) }.flatten
      end
      prototypes
    end

    def expand_outlines(sentence, example)
      result = []
      headers = example[:tableHeader][:cells].map { |cell| cell[:value] }
      example[:tableBody].each do |row| # .slice(1, example[:tableBody].length).each do |row|
        modified_sentence = sentence.dup
        headers.zip(row[:cells].map { |cell| cell[:value] }).map do |key, value|
          modified_sentence.gsub!("<#{key}>", value)
        end
        result.push modified_sentence
      end
      result
    end
  end
end
