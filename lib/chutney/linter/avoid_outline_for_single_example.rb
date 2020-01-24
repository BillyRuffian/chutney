module Chutney
  # service class to lint for avoiding outline for single example
  class AvoidOutlineForSingleExample < Linter
    def lint
      scenarios do |feature, scenario|
        next unless scenario[:type] == :ScenarioOutline

        next unless scenario.key? :examples
        next if scenario[:examples].length > 1
        next if scenario[:examples].first[:tableBody].length > 1
        
        add_issue(I18n.t('linters.avoid_outline_for_single_example'), feature, scenario)
      end
    end
  end
end
