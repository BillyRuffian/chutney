# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding outline for single example
  class AvoidOutlineForSingleExample < Linter
    def lint
      scenarios do |feature, scenario|
        next unless scenario.is_a? CukeModeler::Outline
        next unless scenario.examples

        next if scenario.examples.length > 1
        next if scenario.examples.first.nil? # dont run lint if the example does not exist
        next if scenario.examples.first.rows.length > 2 # first row is the header

        add_issue(I18n.t('linters.avoid_outline_for_single_example'), feature, scenario)
      end
    end
  end
end
