require 'chutney/linter'

# rubocop:disable Lint/MissingCopEnableDirective
module Chutney
  # service class to lint for too long steps
  class TooLongStep < Linter
    
    def initialize
      @maxlength = 80
      super
    end
  
    MESSAGE = 'This step is too long at %d characters'.freeze
    
    def lint
      steps do |file, feature, scenario, step|
        next if step[:text].length <= @maxlength
        
        references = [reference(file, feature, scenario, step)]
        add_error(references, MESSAGE % step[:text].length)
      end
    end
    
    # rubocop:disable Style/TrivialAccessors
    def maxlength(length)
      @maxlength = length
    end
  end
end
