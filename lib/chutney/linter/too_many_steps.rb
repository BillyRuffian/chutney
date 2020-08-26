module Chutney
  # service class to lint for too many steps
  class TooManySteps < Linter
    def lint
      filled_scenarios do |feature, scenario|
        next if scenario.steps.length <= maxcount
        
        add_issue(
          I18n.t('linters.too_many_steps', count: scenario.steps.length, max: maxcount), 
          feature
        )
      end
    end
    
    def maxcount
      configuration['MaxCount']&.to_i || 10
    end
  end
end
