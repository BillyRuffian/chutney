# frozen_string_literal: true

require 'term/ansicolor'

module Chutney
  # entity value class for issues
  class Issue
    include Term::ANSIColor
    attr_reader :name, :references, :description

    def initialize(name, references, description = nil)
      @name = name
      @references = references
      @description = description
    end
  end

  # entity value class for errors
  class Error < Issue
    def render
      result = red(@name)
      result += " - #{@description}" unless @description.nil?
      result += "\n  " + green(@references.uniq * "\n  ")
      result
    end
  end

  # entity value class for warnings
  class Warning < Issue
    def render
      result = "#{yellow(@name)} (Warning)"
      result += " - #{@description}" unless @description.nil?
      result += "\n  " + green(@references.uniq * "\n  ")
      result
    end
  end
end
