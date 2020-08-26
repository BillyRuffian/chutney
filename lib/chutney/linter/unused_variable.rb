module Chutney
  # service class to lint for unused variables
  class UnusedVariable < Linter
    def lint
      scenarios do |feature, scenario|
        next unless scenario.is_a? CukeModeler::Outline
      
        scenario.examples.each do |example|
          
          example.rows.first.cells.map { |cell| cell.value }.each do |variable|
            next if used?(variable, scenario)

            add_issue(I18n.t('linters.unused_variable', variable: variable), feature, scenario, example)
          end
        end
      end
    end

    def used?(variable, scenario)
      variable = "<#{variable}>"
      
      scenario.steps.each do |step|
        return true if step.text.include? variable
        next unless step.block
        return true if used_in_docstring?(variable, step)
        return true if used_in_table?(variable, step)
      end
      false
    end

    def used_in_docstring?(variable, step)
      step.block.is_a?(CukeModeler::DocString) && step.block.content.include?(variable)
    end

    def used_in_table?(variable, step)
      return false unless step.block.is_a?(CukeModeler::Table)
      
      step.block.rows.each do |row|
        row.cells.each { |cell| return true if cell.value.include?(variable) }
      end
      false
    end
  end
end
