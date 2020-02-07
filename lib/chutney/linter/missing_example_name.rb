module Chutney
  # service class to lint for missing example names
  class MissingExampleName < Linter
  
    def lint
      scenarios do |_feature, scenario|
        next unless scenario[:examples]

        scenario[:examples].each do |example|
          example_count = scenario[:examples]&.length || 0
          next unless example_count > 1
          
          check_example(scenario, example)
        end
      end
    end               

    def check_example(scenario, example)
      name = example.key?(:name) ? example[:name].strip : ''
      duplicate_name_count = scenario[:examples].filter { |e| e[:name] == name }.count
      add_issue(I18n.t('linters.missing_example_name'), feature, scenario, example) if duplicate_name_count >= 2
    end
    
  end
end
