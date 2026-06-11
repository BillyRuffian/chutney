# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding tags
  class AvoidTags < Linter
    def lint
      return if feature.nil?

      feature_tags = tags_for(feature)
      feature_tags_to_avoid_found = feature_tags & tags_to_avoid

      unless feature_tags_to_avoid_found.empty?
        feature_tags_to_avoid_found = feature_tags_to_avoid_found.map { |tag| tag.prepend('@') }
        add_issue(I18n.t('linters.avoid_tags', tags: feature_tags_to_avoid_found.join(', ')), feature)
      end

      scenarios do |_feature, scenario|
        scenario_tags = tags_for(scenario)
        scenario_tags_to_avoid_found = scenario_tags & tags_to_avoid

        unless scenario_tags_to_avoid_found.empty?
          scenario_tags_to_avoid_found = scenario_tags_to_avoid_found.map { |tag| tag.prepend('@') }
          add_issue(I18n.t('linters.avoid_tags', tags: scenario_tags_to_avoid_found.join(', ')), feature, scenario)
        end
      end
    end

    def tags_to_avoid
      tags_to_avoid = configuration['Tags'] || []

      return [] unless tags_to_avoid.is_a?(Array)

      tags_to_avoid
    end
  end
end
