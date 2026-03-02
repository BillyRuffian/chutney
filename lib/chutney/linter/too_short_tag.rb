# frozen_string_literal: true

module Chutney
  # service class to lint for single character tags, such as @t
  class TooShortTag < Linter
    def lint
      scenarios do |feature, scenario|
        tags = tags_for(feature) + tags_for(scenario)
        next unless tags.any? { |tag| tag.length < min_length }

        add_issue(
          I18n.t('linters.too_short_tag'),
          feature
        )
      end
    end

    def min_length
      configuration['MinLength']&.to_i || 2
    end
  end
end
