# frozen_string_literal: true

module Chutney
  # service class to lint for bad scenario names  
  class GivensAfterBackground < Linter
    def lint
      return unless background
      
      filled_scenarios do |feature, scenario|
        scenario.steps.each do |step|
          add_issue(I18n.t('linters.givens_after_background'), feature, scenario, step) if given_word?(step.keyword)
        end
      end
    end
  end
end
