# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding splats
  class AvoidSplatStepsInBackground < Linter
    def lint
      background do |feature, background|
        splat_steps = background&.steps&.select { |s| s.keyword == '*' }
        # add_issue(I18n.t('linters.avoid_full_stop'), feature, child, step) if step.text.strip.end_with? '.'
        if splat_steps && !splat_steps.empty?
          add_issue(I18n.t('linters.avoid_splat_steps_in_background'), feature, background, splat_steps.first)
        end
      end
    end
  end
end
