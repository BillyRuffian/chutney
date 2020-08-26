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
      return unless feature.children
      
      has_non_given_step = false
      scenarios do |_feature, scenario|
        next unless scenario.steps
        
        has_non_given_step = true unless given_word?(scenario.steps.first.keyword)
      end
      return if has_non_given_step

      result = []
      expanded_steps { |given| result.push given }
      result
    end

    def expanded_steps
      scenarios do |_feature, scenario|
        next unless scenario.steps
        
        prototypes = [render_step(scenario.steps.first)]
        prototypes = expand_examples(scenario.examples, prototypes) if scenario.is_a? CukeModeler::Outline
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
      headers = example.rows.first.cells.map { |cell| cell.value }
      example.rows.each_with_index do |row, idx|
        next if idx.zero? # skip the header
        
        modified_sentence = sentence.dup
        headers.zip(row.cells.map { |cell| cell.value }).map do |key, value|
          modified_sentence.gsub!("<#{key}>", value)
        end
        result.push modified_sentence
      end
      result
    end
  end
end
