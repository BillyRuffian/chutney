module Chutney
  # service class to lint for missing feature descriptions
  class MissingFeatureDescription < Linter
    MESSAGE = 'Features should have a description so that its purpose is clear'.freeze
    def lint
      return unless feature
      
      name = feature.key?(:description) ? feature[:description].strip : ''
      add_issue(I18n.t('linters.missing_feature_description'), feature) if name.empty?
    end
  end
end
