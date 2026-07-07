# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding tags
  class AvoidMutuallyExclusiveTags < Linter
    def lint
      return if feature.nil?

      feature_tags = tags_for(feature)
      scenarios do |_feature, scenario|
        scenario_tags = tags_for(scenario)
        # use [nil] for plain scenarios so the loop runs once with no example tags
        examples_blocks = scenario.respond_to?(:examples) ? scenario.examples : [nil]

        tag_groups.each do |group|
          check_group(group, feature_tags, scenario, scenario_tags, examples_blocks)
        end
      end
    end

    private

    def check_group(group, feature_tags, scenario, scenario_tags, examples_blocks)
      # seed seen_tags with any exclusive tags already present at feature/scenario level
      seen_tags = (feature_tags + scenario_tags) & group
      reported_scenario = (scenario_tags & group).any? ? scenario : nil
      reported_examples = nil

      # accumulate exclusive tags across each "Examples:" block, tracking the last element with a group tag
      examples_blocks.each do |examples|
        example_tags = examples ? tags_for(examples) : []
        seen_tags += example_tags & group
        if example_tags.intersect?(group)
          reported_examples = examples
          reported_scenario = scenario
        end
      end

      return if seen_tags.length < 2

      # report at the deepest location: examples > scenario > feature
      formatted = seen_tags.map { |t| "@#{t}" }.join(', ')
      add_issue(
        I18n.t('linters.avoid_mutually_exclusive_tags', tags: formatted), feature, reported_scenario, reported_examples
      )
    end

    def tag_groups
      groups = configuration['TagGroups'] || []
      groups.is_a?(Array) ? groups : []
    end
  end
end
