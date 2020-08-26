module Chutney
  # service class to lint for missing scenario names
  class MissingScenarioName < Linter  
  
    def lint
      scenarios do |feature, scenario|
        add_issue(I18n.t('linters.missing_scenario_name'), feature, scenario) if scenario.name.empty?
      end
    end
  end
end
