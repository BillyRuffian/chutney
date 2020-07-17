module Chutney
  # service class to lint for avoid scripting
  class AvoidTypographersQuotes < Linter
    TYPOGRAPHER_QUOTES = ["\u201c", "\u201d", "\u2018", "\u2019"].map(&:encode)

    def lint
      scenarios do |_feature, scenario|
        lint_steps(scenario[:steps])

        example_count = scenario[:examples]&.length || 0
        next unless example_count.positive?

        lint_examples(scenario[:examples])
      end
    end

    def lint_steps(steps)
      steps.each do |step|
        issue(step) if TYPOGRAPHER_QUOTES.any? { |tq| step[:text].include? tq }
      end
    end

    def lint_examples(examples)
      examples.each do |example|
        example[:tableBody].each do |body|
          body[:cells].each do |cell|
            issue(cell) if TYPOGRAPHER_QUOTES.any? { |tq| cell[:value].include? tq }
          end
        end
      end
    end

    def issue(location)
      add_issue(I18n.t('linters.avoid_typographers_quotes'), location)
    end
  end
end
