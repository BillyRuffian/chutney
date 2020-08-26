# frozen_string_literal: true

module Chutney
  # service class to lint for missing feature descriptions
  class MissingFeatureDescription < Linter
    MESSAGE = 'Features should have a description so that its purpose is clear'
    def lint
      return unless feature
      
      add_issue(I18n.t('linters.missing_feature_description'), feature) if feature.description.empty?
    end
  end
end
