# frozen_string_literal: true

module Chutney
  # service class to lint for missing feature names
  class MissingFeatureName < Linter
    def lint
      return unless feature

      add_issue(I18n.t('linters.missing_feature_name'), feature) if feature.name.empty?
    end
  end
end
