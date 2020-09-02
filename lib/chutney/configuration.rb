# frozen_string_literal: true

module Chutney 
  # gherkin_lint configuration object
  class Configuration < SimpleDelegator
    def initialize(path)
      @path = path
      @config = load_configuration || {}
      load_user_configuration
      super(@config)
    end

    def configuration_path
      @path
    end

    def load_configuration
      YAML.load_file configuration_path || '' if configuration_path
    end

    def load_user_configuration
      config_files = ['chutney.yml', '.chutney.yml'].map do |fname|
        Dir.glob(File.join(Dir.pwd, '**', fname))
      end.flatten
      
      config_file = config_files.first
      merge_config(config_file) if !config_file.nil? && File.exist?(config_file)
    end

    private

    def merge_config(config_file)
      @config.merge!(YAML.load_file(config_file)) { |_k, old, new| old.merge!(new) } unless @config.empty?
    end
  end
end
