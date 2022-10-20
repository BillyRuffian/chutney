# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for missing example tables in scnario outlines
  class MissingExampleTable < Linter
    def lint
      scenarios do |_feature, scenario|
        next unless scenario.is_a? CukeModeler::Outline
        next unless scenario.examples.empty?

        add_issue(I18n.t('linters.missing_example_table'), feature, scenario)
      end
    end
  end
end
