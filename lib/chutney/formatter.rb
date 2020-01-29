module Chutney
  # base class for all formatters
  class Formatter
    attr_accessor :results
    
    def initialize
      @results = {}
    end  
    
    def format(results); end
    
    def files
      results.map { |k, _v| k }
    end
    
    def files_with_issues
      results.filter { |_k, v| v.any? { |r| r[:issues].count.positive? } }
    end
    
  end
end
