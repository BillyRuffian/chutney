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

        tag_groups.each do |group|
          # seed seen_tags with any exclusive tags already present at feature/scenario level
          seen_tags = (feature_tags + scenario_tags) & group
          reported_scenario = scenario_tags.any? { |t| group.include?(t) } ? scenario : nil
          reported_examples = nil

          # accumulate exclusive tags across each "Examples:" block, tracking the last element with a mutually exclusive tag
          examples_blocks.each do |examples|
            example_tags = examples ? tags_for(examples) : []
            seen_tags += example_tags & group
            if example_tags.intersect?(group)
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
    end

    def tag_groups
      groups = configuration['TagGroups'] || []
      groups.is_a?(Array) ? groups : []
    end
  end
end
