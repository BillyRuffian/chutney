require 'chutney/linter'

module Chutney
  # service class to lint for tags used multiple times
  class ScenarioNamesMatch < Linter
    MESSAGE = 'Scenario Name does not match pattern'.freeze
  

    def lint
      scenarios do |file, feature, scenario|
        name = scenario.key?(:name) ? scenario[:name].strip : ''
        references = [reference(file, feature, scenario)]
        next unless (name =~ /#{@pattern}/).nil?
        
        add_warning(references, MESSAGE)
      end
    end
    
    def matcher(pattern)
      @pattern = pattern
    end
  end
end
