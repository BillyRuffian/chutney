module Chutney

  class SameScenario < Linter
    def lint
      dictionary = Hash.new { |hash, key| hash[key] = [] }

      scenarios do |feature, scenario|
        text = scenario
                 .steps
                 .map { |step| "#{step.text} #{child_text(step)}" }
                 .join("\n") + example_text(scenario)

        digest = Digest::SHA2.hexdigest(text)
        dictionary[digest] << { scenario:, feature: }
      end

      dictionary.filter { |k, v| v.size > 1 }
                .each_value do |v|
        v[1...].each { |problem|
          add_issue(I18n.t('linters.same_scenario',
                           feature: problem[:feature].name,
                           scenario: problem[:scenario].name,
                           original_feature: v.first[:feature].name,
                           original_scenario: v.first[:scenario].name),
                    problem[:feature], problem[:scenario], nil) }
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