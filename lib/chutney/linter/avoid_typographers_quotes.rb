# frozen_string_literal: true

module Chutney
  # service class to lint for avoid scripting
  class AvoidTypographersQuotes < Linter
    TYPOGRAPHER_QUOTES = ["\u201c", "\u201d", "\u2018", "\u2019"].map(&:encode)

    def lint
      scenarios do |feature, scenario|
        lint_steps(feature, scenario)

        example_count = scenario.is_a?(CukeModeler::Outline) ? scenario.examples.length : 0
        next unless example_count.positive?

        lint_examples(feature, scenario)
      end
    end

    def lint_steps(feature, scenario)
      scenario.steps.each do |step|
        issue(feature, scenario, step) if TYPOGRAPHER_QUOTES.any? { |tq| step.text.include? tq }
      end
    end

    def lint_examples(feature, scenario)
      scenario.examples.each do |example|
        example.rows.each do |row|
          row.cells.each do |cell|
            issue(feature, scenario, cell) if TYPOGRAPHER_QUOTES.any? { |tq| cell.value.include? tq }
          end
        end
      end
    end

    def issue(feature, scenario, location)
      add_issue(I18n.t('linters.avoid_typographers_quotes'), feature, scenario, location)
    end
  end
end
