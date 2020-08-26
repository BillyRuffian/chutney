module Chutney
  # service class to lint for unknown variables
  class UnknownVariable < Linter
    def lint
      filled_scenarios do |feature, scenario|
        known_vars = Set.new(known_variables(scenario))
        scenario.steps.each do |step|
          step_vars(step).each do |used_var|
            next if known_vars.include? used_var
            
            add_issue(
              I18n.t('linters.unknown_variable', variable: used_var), feature, scenario
            )
          end
        end
      end
    end

    def step_vars(step)
      vars = gather_vars step.text
      return vars unless step.block
      
      vars + gather_vars_from_argument(step.block)
    end

    def gather_vars_from_argument(argument)
      return gather_vars argument.content if argument.is_a? CukeModeler::DocString

      argument.rows.map do |row|
        row.cells.map { |cell| gather_vars cell.value }.flatten
      end.flatten
    end

    def gather_vars(string)
      string.scan(/<.+?>/).map { |val| val[1..-2] }
    end

    def known_variables(scenario)
      return [] unless scenario.is_a? CukeModeler::Outline
    
      scenario.examples.map { |ex| ex.rows.first.cells.map(&:value) }.flatten
    end
  end
end
