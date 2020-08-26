# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for missing verifications
  class MissingVerification < Linter
    def lint
      filled_scenarios do |feature, scenario|
        then_steps = scenario.steps.select { |step| then_word?(step.keyword) }
        next unless then_steps.empty?
        
        add_issue(I18n.t('linters.missing_test_verification'), feature, scenario)
      end
    end
  end
end
