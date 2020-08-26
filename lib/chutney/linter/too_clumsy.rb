# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for too clumsy scenarios
  class TooClumsy < Linter
    def lint
      filled_scenarios do |feature, scenario|
        characters = scenario.steps.map { |step| step.text.length }.inject(0, :+)
        next if characters < 400
        
        add_issue(
          I18n.t('linters.too_clumsy', length: characters), feature, scenario
        )
      end
    end
  end
end
