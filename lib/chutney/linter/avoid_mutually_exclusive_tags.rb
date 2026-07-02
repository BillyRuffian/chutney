# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding tags
  class AvoidMutuallyExclusiveTags < Linter
    def lint
      return if feature.nil?

      feature_tags = tags_for(feature)
      scenarios do |_feature, scenario|
        scenario_tags = tags_for(scenario)

        # use [nil] for plain scenarios so the loop below runs once with no example tags
        examples_blocks = scenario.respond_to?(:examples) ? scenario.examples : [nil]

        # seed seen_tags with any exclusive tags already present at feature/scenario level
        seen_tags = (feature_tags + scenario_tags) & mutually_exclusive_tags
        reported_scenario = scenario_tags.any? { |t| mutually_exclusive_tags.include?(t) } ? scenario : nil
        reported_examples = nil

        # accumulate exclusive tags across each Examples: block, tracking where the clash first occurs
        examples_blocks.each do |examples|
          example_tags = examples ? tags_for(examples) : []
          no_clash_yet = seen_tags.length < 2
          seen_tags += example_tags & mutually_exclusive_tags
          if no_clash_yet && seen_tags.length >= 2
            reported_examples = examples
            reported_scenario = scenario
          end
        end

        next if seen_tags.length < 2
        formatted_exclusives = seen_tags.map { |tag| "@#{tag}" }.join(', ')
        # report at the most specific location: examples > scenario > feature
        add_issue(I18n.t('linters.avoid_mutually_exclusive_tags', tags: formatted_exclusives), feature, reported_scenario, reported_examples)
      end
    end

    def mutually_exclusive_tags
      tags = configuration['Tags'] || []
      tags.is_a?(Array) ? tags : []
    end
  end
end
