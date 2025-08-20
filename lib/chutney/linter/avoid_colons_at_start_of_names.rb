# frozen_string_literal: true

module Chutney
  # service class to lint for avoiding colons at the start of names
  class AvoidColonsAtStartOfNames < Linter
    def lint
      unless feature.nil?
        add_issue(I18n.t('linters.avoid_colons_at_start_of_names'), feature) if feature.name.start_with? ':'
      end

      scenarios do |_feature, scenario|
        if scenario.name.start_with? ':'
          add_issue(I18n.t('linters.avoid_colons_at_start_of_names'), feature,
                    scenario)
        end
      end
    end
  end
end
