module Chutney
  # service class to lint for bad scenario names  
  class GivensAfterBackground < Linter
    def lint
      return unless background
      
      filled_scenarios do |feature, scenario|
        scenario.steps.each do |step|
          if given_word?(step.keyword)
            add_issue(I18n.t('linters.givens_after_background'), feature, scenario, step)
          end
        end
      end
    end
  end
end
