require 'chutney/linter'

module Chutney
  # service class for check that there are multiple scenarios once a background is used
  class BackgroundRequiresMultipleScenarios < Linter
    MESSAGE = 'Avoid using Background steps for just one scenario'.freeze
  
    def lint
      background do |feature, background|
        next unless feature&.tests
        next if feature.tests.length >= 2

        add_issue(I18n.t('linters.background_requires_multiple_scenarios'), feature, background)
      end
    end
  end
end
