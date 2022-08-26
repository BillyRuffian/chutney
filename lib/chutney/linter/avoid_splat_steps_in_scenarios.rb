# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding splats
  class AvoidSplatStepsInScenarios < Linter
    def lint
      steps do |feature, child, step|
        add_issue(I18n.t('linters.avoid_splat_steps_in_scenarios'), feature, child, step) if step.keyword == '*'
      end
    end
  end
end
