module Chutney
  # service class to lint for tags used multiple times
  class RequiredTagsStartsWith < Linter
        
    def lint
      scenarios do |feature, scenario|
        next if match_pattern? tags_for(feature)
        next if match_pattern? tags_for(scenario)
        
        add_issue(
          I18n.t('linters.required_tags_starts_with', 
                 allowed: configuration['Matcher'].join(', ')), 
          feature, scenario
        )
      end
    end
  
    def match_pattern?(target)
      target.each do |t|
        return true if t.start_with?(*configuration['Matcher'])
      end
      false
    end
  end
end
