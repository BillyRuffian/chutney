module Chutney
  # service class to lint for missing feature names
  class MissingFeatureName < Linter    
    def lint
      name = feature.key?(:name) ? feature[:name].strip : ''
      add_issue(I18n.t('linters.missing_feature_name'), feature) if name.empty?
    end
  end
end
