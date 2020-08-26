module Chutney
  # service class to lint for bad scenario names  
  class BadScenarioName < Linter
    def lint
      scenarios do |feature, scenario|
        next if scenario.name.empty?
        
        bad = /\w*(test|verif|check)\w*/i
        match = scenario.name.match(bad).to_a.first
        add_issue(I18n.t('linters.bad_scenario_name', word: match), feature, scenario) if match
      end
    end
  end
end
