module Chutney
  # service class to lint for missing scenario names
  class MissingScenarioName < Linter  
  
    def lint
      scenarios do |feature, scenario|
        name = scenario.key?(:name) ? scenario[:name].strip : ''
        next unless name.empty?
        
        add_issue(I18n.t('linters.missing_scenario_name'), feature, scenario) if name.empty?
      end
    end
  end
end
