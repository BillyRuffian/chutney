# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding tags
  class AvoidTags < Linter
    def lint
      return if feature.nil?

      check_tags(feature, feature)

      scenarios do |_feature, scenario|
        check_tags(scenario, feature, scenario)

        next unless scenario.respond_to?(:examples)

        scenario.examples.each do |examples|
          check_tags(examples, feature, scenario, examples)
        end
      end
    end

    private

    def check_tags(element, *location)
      found = tags_for(element) & tags_to_avoid
      return if found.empty?

      add_issue(I18n.t('linters.avoid_tags', tags: found.map { |t| "@#{t}" }.join(', ')), *location)
    end

    def tags_to_avoid
      tags = configuration['Tags'] || []
      tags.is_a?(Array) ? tags : []
    end
  end
end
