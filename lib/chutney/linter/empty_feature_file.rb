# frozen_string_literal: true

module Chutney
  # service class to lint for Features that have no content
  class EmptyFeatureFile < Linter
    def lint
      add_issue(I18n.t('linters.empty_feature_file')) if feature.nil?
    end
  end
end
