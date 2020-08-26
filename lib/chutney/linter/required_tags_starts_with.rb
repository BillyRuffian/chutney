# frozen_string_literal: true

module Chutney
  # service class to lint for tags used multiple times
  class RequiredTagsStartsWith < Linter
        
    def lint
      return unless pattern

      scenarios do |feature, scenario|
        next if match_pattern? tags_for(feature)
        next if match_pattern? tags_for(scenario)
        
        add_issue(
          I18n.t('linters.required_tags_starts_with', 
                 allowed: pattern.join(', ')), 
          feature, scenario
        )
      end
    end
    
    def pattern
      configuration['Matcher'] || nil
    end
  
    def match_pattern?(target)
      target.each do |t|
        return true if t.start_with?(*pattern)
      end
      false
    end
  end
end
