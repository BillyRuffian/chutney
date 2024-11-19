# frozen_string_literal: true

module Chutney
  # service class to lint for too many tags
  class AvoidCommaInTags < Linter
    def lint
      scenarios do |feature, scenario|
        tags = tags_for(feature) + tags_for(scenario)
        next unless tags.any? { |tag| tag.include?(',') }

        add_issue(
          I18n.t('linters.avoid_comma_in_tags'),
          feature
        )
      end
    end
  end
end
