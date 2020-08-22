module Chutney
  # service class to lint for Features that have no content
  class EmptyFeatureFile < Linter
    def lint
      add_issue(I18n.t('linters.empty_feature_file'), { name: @filename.split('/').last }) if feature.nil?
    end
  end
end
