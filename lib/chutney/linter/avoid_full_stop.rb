module Chutney
  # service class to lint for avoiding periods
  class AvoidFullStop < Linter    
    def lint
      steps do |feature, child, step|
        
        add_issue(I18n.t('linters.avoid_full_stop'), feature, child, step) if step.text.strip.end_with? '.'
        
      end
    end
  end
end
