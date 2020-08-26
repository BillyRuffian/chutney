# frozen_string_literal: true

require 'chutney/linter'

module Chutney
  # service class to lint for invalid file names
  class InvalidFileName < Linter
    def lint
      feature do |f|
        base = File.basename(filename, '.*')
        if base != base.downcase || base =~ /[ -]/
          add_issue(I18n.t('linters.invalid_file_name', recommended_name: recommend(filename)), f)
        end
      end
    end
    
    def recommend(filename)
      File.basename(filename, '.*').gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .tr(' ', '_')
          .downcase << '.feature'
    end
  end
end
