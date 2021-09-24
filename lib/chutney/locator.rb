# frozen_string_literal: true

module Chutney
  # Utility module to assist in locating the source of parts of a gherkin specification
  module Locator
    module_function

    def locate(feature, scenario, step)
      if step
        locate_step(step)
      elsif scenario
        locate_scenario(scenario)
      elsif feature
        locate_feature(feature)
      else
        feature
      end
    end

    def locate_step(step)
      return step.parsing_data.location.to_h if step.parsing_data.respond_to?(:location)
      return step.parsing_data[:location] if step.parsing_data.is_a?(Hash)

      raise UnsupportedCucumberError, 'This version of cucumber is unsupported (step location)'
    end

    def locate_scenario(scenario)
      parsing_data = scenario.parsing_data

      if parsing_data.is_a?(Hash)
        parsing_data.dig(:scenario, :location) || parsing_data.dig(:background, :location)
      elsif parsing_data.respond_to?(:scenario)
        (parsing_data.scenario || parsing_data.background).location.to_h
      else
        raise UnsupportedCucumberError, 'This version of cucumber is unsupported (scenario location)'
      end
    end

    def locate_feature(feature)
      return feature.parsing_data.location.to_h if feature.parsing_data.respond_to?(:location)
      return feature.parsing_data[:location] if feature.parsing_data.is_a?(Hash)

      raise UnsupportedCucumberError, 'This version of cucumber is unsupported (feature location)'
    end
  end
end
