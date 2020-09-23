# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for using same tag on all scenarios
  class SameTagForAllScenarios < Linter
    def lint
      lint_scenarios if feature&.scenarios
      lint_examples  if feature&.scenarios
    end

    def lint_scenarios
      tags = scenario_tags
      return if tags.nil? || tags.empty?
      return unless feature.tests.length > 1

      tags.each do |tag|
        next if tag == 'skip'

        add_issue(
          I18n.t('linters.same_tag_for_all_scenarios.feature_level',
                 tag: tag),
          feature
        )
      end
    end

    def lint_examples
      scenarios do |_feature, scenario|
        tags = example_tags(scenario)
        next if tags.nil? || tags.empty?
        next unless scenario.is_a? CukeModeler::Outline
        next unless scenario.examples.length > 1

        tags.each do |tag|
          next if tag == 'skip'

          add_issue(I18n.t('linters.same_tag_for_all_scenarios.example_level',
                           tag: tag), feature, scenario)
        end
      end
    end

    def scenario_tags
      result = nil
      scenarios do |_feature, scenario|
        tags = tags_for(scenario)
        result ||= tags
        result &= tags
      end
      result
    end

    def example_tags(scenario)
      result = nil
      return result unless scenario.is_a?(CukeModeler::Outline) && scenario.examples

      scenario.examples.each do |example|
        return nil unless example.tags

        tags = tags_for(example)
        result = tags if result.nil?

        result &= tags
      end
      result
    end
  end
end
