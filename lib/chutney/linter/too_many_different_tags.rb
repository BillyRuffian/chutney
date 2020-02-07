module Chutney
  # service class to lint for too many different tags
  class TooManyDifferentTags < Linter
    def lint
      tags = all_tags
      return if tags.length <= maxcount
      
      add_issue(
        I18n.t('linters.too_many_different_tags', count: tags.length, max: maxcount), 
        feature
      )
    end
    
    def maxcount 
      configuration['MaxCount']&.to_i || 3
    end
    
    def all_tags
      return [] unless feature.include?(:children)
      
      tags_for(feature) + feature[:children].map { |scenario| tags_for(scenario) }.flatten
    end
  end
end
