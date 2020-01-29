module Chutney
  # Plain old JSON formatter
  class JSONFormatter < Formatter
    def format
      puts @results.to_json
    end
  end
end
