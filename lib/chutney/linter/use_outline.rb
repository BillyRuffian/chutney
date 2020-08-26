# frozen_string_literal: true

module Chutney
  # service class to lint for using outline
  class UseOutline < Linter
    def lint
      check_similarity(gather_scenarios(feature))
    end

    def check_similarity(scenarios)
      scenarios.product(scenarios) do |lhs, rhs|
        next if lhs == rhs
        next if lhs[:reference][:line] > rhs[:reference][:line]
        
        similarity = determine_similarity(lhs[:text], rhs[:text])
        next unless similarity >= 0.95
        
        similarity_pct = similarity.round(3) * 100
        
        add_issue(lhs, rhs, similarity_pct)
      end
    end
    
    def add_issue(lhs, rhs, pct)
      super(I18n.t('linters.use_outline', 
                   pct: pct,
                   lhs_name: lhs[:name],
                   lhs_line: lhs[:reference][:line],
                   rhs_name: rhs[:name],
                   rhs_line: rhs[:reference][:line]),
                  feature)
    end

    def determine_similarity(lhs, rhs)
      matcher = Amatch::Jaro.new(lhs)
      matcher.match(rhs)
    end

    def gather_scenarios(feature)
      scenarios = []
      return scenarios if feature.nil? || !feature.tests
      
      scenarios do |_feature, scenario|
        next unless scenario.steps
        next if scenario.steps.empty?
        
        scenarios.push generate_reference(feature, scenario)
      end
      scenarios
    end

    def generate_reference(feature, scenario)
      reference = {}
      reference[:reference] = location(feature, scenario, nil)
      reference[:name] = "#{scenario.keyword}: #{scenario.name}"
      reference[:text] = scenario.steps.map { |step| render_step(step) }.join ' '
      reference
    end
  end
end
