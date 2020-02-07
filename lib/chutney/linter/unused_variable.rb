module Chutney
  # service class to lint for unused variables
  class UnusedVariable < Linter
    def lint
      scenarios do |feature, scenario|
        next unless scenario.key?(:examples)
        
        scenario[:examples].each do |example|
          next unless example.key?(:tableHeader)
          
          example[:tableHeader][:cells].map { |cell| cell[:value] }.each do |variable|
            next if used?(variable, scenario)

            add_issue(I18n.t('linters.unused_variable', variable: variable), feature, scenario, example)
          end
        end
      end
    end

    def used?(variable, scenario)
      variable = "<#{variable}>"
      return false unless scenario.key? :steps
      
      scenario[:steps].each do |step|
        return true if step[:text].include? variable
        next unless step.include? :argument
        return true if used_in_docstring?(variable, step)
        return true if used_in_table?(variable, step)
      end
      false
    end

    def used_in_docstring?(variable, step)
      step[:argument][:type] == :DocString && step[:argument][:content].include?(variable)
    end

    def used_in_table?(variable, step)
      return false unless step[:argument][:type] == :DataTable
      
      step[:argument][:rows].each do |row|
        row[:cells].each { |value| return true if value[:value].include?(variable) }
      end
      false
    end
  end
end
