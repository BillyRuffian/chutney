# frozen_string_literal: true

module Chutney
  # service class to lint for too many tags
  class TooManyTags < Linter
    def lint
      scenarios do |feature, scenario|
        tags = tags_for(feature) + tags_for(scenario)
        next unless tags.length > maxcount

        add_issue(
          I18n.t('linters.too_many_tags', count: tags.length, max: maxcount),
          feature
        )
      end
    end

    def maxcount
      configuration['MaxCount']&.to_i || 3
    end
  end
end
