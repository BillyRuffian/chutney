module Chutney
  # service class to lint for file name differs feature name
  class FileNameDiffersFeatureName < Linter
    def lint
      return unless feature.include? :name
        
      expected_feature_name = title_case(filename)
      return if ignore_whitespaces(feature[:name]).casecmp(ignore_whitespaces(expected_feature_name)) == 0
        
      add_issue(I18n.t('linters.file_name_differs_feature_name', expected: expected_feature_name), feature) 
    end

    def title_case(value)
      value = File.basename(value, '.*')
      value.split('_').collect(&:capitalize).join(' ')
    end

    def ignore_whitespaces(value)
      value.delete('-').delete('_').delete(' ')
    end
  end
end
