module Chutney
  # service class to lint for invalid step flow
  class InvalidStepFlow < Linter
    def lint
      filled_scenarios do |feature, scenario|
        steps = scenario[:steps].select { |step| !and_word?(step[:keyword]) && !but_word?(step[:keyword]) }
        next if steps.empty?
        
        last_step_is_an_action(feature, scenario, steps)
        given_after_non_given(feature, scenario, steps)
        verification_before_action(feature, scenario, steps)
      end
    end

    def last_step_is_an_action(feature, scenario, steps)
      return unless when_word?(steps.last[:keyword])

      add_issue(I18n.t('linters.invalid_step_flow.action_last'), feature, scenario, steps.last)
    end

    def given_after_non_given(feature, scenario, steps)
      last_step = steps.first
      steps.each do |step|
        if given_word?(step[:keyword]) && !given_word?(last_step[:keyword])
          add_issue(I18n.t('linters.invalid_step_flow.given_order'), feature, scenario, step)
        end
        last_step = step
      end
    end

    def verification_before_action(feature, scenario, steps)
      steps.each do |step|
        break if when_word?(step[:keyword])
        
        if then_word?(step[:keyword])
          add_issue(I18n.t('linters.invalid_step_flow.missing_action'), feature, scenario)
        end
      end
    end
  end
end
