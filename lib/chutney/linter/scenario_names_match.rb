# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for tags used multiple times
  class ScenarioNamesMatch < Linter
    MESSAGE = 'Scenario Name does not match pattern'

    def lint
      scenarios do |feature, scenario|
        next unless (scenario.name =~ /#{configuration['Matcher']}/).nil?

        add_issue(
          I18n.t('linters.scenario_names_match',
                 pattern: configuration['Matcher']), feature, scenario
        )
      end
    end
  end
end
