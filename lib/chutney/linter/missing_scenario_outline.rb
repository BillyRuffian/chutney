# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for missing scenario outlines when examples tables given
  class MissingScenarioOutline < Linter
    def lint
      scenarios do |_feature, scenario|
        next unless scenario.is_a? CukeModeler::Outline
        next unless scenario.keyword == 'Scenario'

        add_issue(I18n.t('linters.missing_scenario_outline'), feature, scenario)
      end
    end
  end
end
