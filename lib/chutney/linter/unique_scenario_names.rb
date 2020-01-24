module Chutney
  # service class to lint for unique scenario names
  class UniqueScenarioNames < Linter
    def lint
      references_by_name = {}
      scenarios do |feature, scenario|
        next unless scenario.key? :name

        name = scenario[:name]
        if references_by_name[name]
          issue(name, references_by_name[name], scenario)
        else
          references_by_name[name] = location(feature, scenario, nil)
        end
      end
    end
    
    def issue(name, first_location, scenario)
      add_issue(
        I18n.t('linters.unique_scenario_names',
               name: name,
               line: first_location[:line],
               column: first_location[:column]), 
        feature, scenario
      )
    end
  end
end
