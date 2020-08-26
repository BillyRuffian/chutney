# frozen_string_literal: true

module Chutney
  # service class to lint for avoid scripting
  class AvoidScripting < Linter  
    def lint
      scenarios do |feature, scenario|
        when_steps = filter_when_steps(scenario.steps)
        whens = when_steps.count
        add_issue(I18n.t('linters.avoid_scripting', count: whens), feature, scenario, when_steps.last) if whens > 1
      end
    end
    
    def filter_when_steps(steps)
      steps
        .drop_while { |step| !when_word?(step.keyword) }
        .then { |s| s.reverse.drop_while { |step| !then_word?(step.keyword) }.reverse }
        .then { |s| s.reject { |step| then_word?(step.keyword) } }
    end
  end
end
