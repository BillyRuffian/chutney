# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding periods
  class InconsistentQuoting < Linter
    # regular expression to extract quoted string
    # matching group 1: opening quote; 2: quoted text; 3: closing quote
    # opening and closing quote must match (via backrefs)
    # apostrophes, both singular and plural posessives, are accounted for
    QUOTED_STRING = /(?!\b\b)(['"])(.*(?:\b'\b[^\1]*)*(?!\b[\1]\b))(\1)/.freeze
    Parameter = Struct.new('Parameter', :quotation_mark, :name)

    def lint
      quoted_params = parameters.group_by(&:quotation_mark)
      single_quoted = quoted_params[%(')] || []
      double_quoted = quoted_params[%(")] || []
      return unless single_quoted.count.positive? && double_quoted.count.positive?

      add_issue(
        I18n.t('linters.inconsistent_quoting',
               count_single: single_quoted.count, count_double: double_quoted.count,
               example_single: %('#{single_quoted.first.name}'), example_double: %("#{double_quoted.first.name}")),
        feature
      )
    end

    def parameters
      parameters = []

      steps do |_feature, _child, step|
        step_parameters = step
                          .text
                          .scan(QUOTED_STRING)
                          .map { |p| p.take(2) } # close quote will match open quote: drop it
                          .map { |p| Parameter.new(*p) }
        parameters.concat(step_parameters)
      end

      parameters
    end
  end
end
