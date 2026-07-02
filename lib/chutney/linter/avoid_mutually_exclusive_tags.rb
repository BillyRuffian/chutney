# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding tags
  class AvoidMutuallyExclusiveTags < Linter
    def lint
      return if feature.nil?

      feature_tags = tags_for(feature)
      scenarios do |_feature, scenario|
        scenario_tags = tags_for(scenario)
        exclusives = (feature_tags + scenario_tags) & mutually_exclusive_tags
        next if exclusives.length < 2

        formatted_exclusives = exclusives.map { |tag| "@#{tag}" }.join(', ')
        # Report on scenario if it has any exclusive tags, otherwise on feature
        if scenario_tags.any? { |t| mutually_exclusive_tags.include?(t) }
          add_issue(I18n.t('linters.avoid_mutually_exclusive_tags', tags: formatted_exclusives), feature, scenario)
        else
          add_issue(I18n.t('linters.avoid_mutually_exclusive_tags', tags: formatted_exclusives), feature)
        end
      end
    end

    def mutually_exclusive_tags
      tags = configuration['Tags'] || []
      tags.is_a?(Array) ? tags : []
    end
  end
end
