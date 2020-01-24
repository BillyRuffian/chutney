module Chutney
  # service class to lint for too long steps
  class TooLongStep < Linter
    def lint
      steps do |feature, scenario, step|
        next if step[:text].length <= maxlength
        
        add_issue(
          I18n.t('linters.too_long_step', length: step[:text].length, max: maxlength), 
          feature, scenario
        )
      end
    end
    
    def maxlength
      configuration['MaxLength'] || '120'
    end
  end
end
