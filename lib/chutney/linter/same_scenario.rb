# frozen_string_literal: true

module Chutney
  # Rule to find all the duplicated scenarios
  class SameScenario < Linter
    def self.reset
      @dictionary = nil
    end

    def self.dictionary
      @dictionary ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def lint # rubocop:disable Metrics/MethodLength
      scenarios do |feature, scenario|
        text = background ? background.steps.map(&:to_s).join("\n").concat("\n") : ''
        text += scenario
                .steps
                .map { |step| "#{step.text} #{child_text(step)}" }
                .join("\n") + example_text(scenario)
        digest = Digest::SHA2.hexdigest(text)
        SameScenario.dictionary[digest] << { scenario:, feature: }
      end

      SameScenario.dictionary.filter { |_k, v| v.size > 1 }
                  .each_value do |v|
                    v[1...].each_with_index do |problem, index|
                      add_issue(I18n.t('linters.same_scenario',
                                       feature: problem[:feature].name,
                                       scenario: problem[:scenario].name,
                                       original_feature: v.first[:feature].name,
                                       original_scenario: v.first[:scenario].name),
                                problem[:feature], problem[:scenario], nil)
                      v.delete_at(index + 1)
                    end
      end
    end

    def child_text(step)
      step.children.map do |child|
        if child.is_a?(CukeModeler::Table)
          child.rows.flat_map(&:cells).map(&:value).join(' | ')
        elsif child.is_a?(CukeModeler::DocString)
          child.content
        else
          ''
        end
      end
    end

    def example_text(scenario)
      if scenario.is_a?(CukeModeler::Outline)
        "\n" + scenario.examples
                       .flat_map(&:rows)
                       .flat_map(&:cells)
                       .map(&:value).join(' | ')
      else
        ''
      end
    end
  end
end
