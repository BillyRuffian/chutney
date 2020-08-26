module Chutney
  # service class to lint for missing test actions
  class MissingTestAction < Linter
    def lint
      filled_scenarios do |feature, scenario|
        when_steps = scenario.steps.select { |step| when_word?(step.keyword) }
        next unless when_steps.empty?
        
        add_issue(I18n.t('linters.missing_test_action'), feature, scenario)
      end
    end
  end
end
