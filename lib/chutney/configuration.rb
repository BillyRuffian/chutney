# frozen_string_literal: true

require 'delegate'

module Chutney
  # gherkin_lint configuration object
  class Configuration < SimpleDelegator
    attr_accessor :default_configuration_path, :user_configuration_path

    def initialize(path)
      @default_configuration_path = path
      @config = load_configuration || {}
      load_user_configuration
      super(@config)
    end

    def load_configuration
      YAML.load_file default_configuration_path || '' if default_configuration_path
    end

    def load_user_configuration
      config_files = ['chutney.yml', '.chutney.yml'].map do |fname|
        ['.', 'config'].map do |dir|
          Dir["#{dir}#{File::SEPARATOR}#{fname}"]
        end
      end.flatten.compact

      self.user_configuration_path = config_files.first
      return unless !user_configuration_path.nil? && File.exist?(user_configuration_path)

      begin
        merge_config(user_configuration_path)
      rescue TypeError
        unless quiet?
          warn("Chutney: configuration file `#{user_configuration_path}` is not correctly formatted YAML, " \
               'falling back to gem defaults.')
        end
      end
    end

    def using_user_configuration?
      !user_configuration_path.nil?
    end

    def quiet?
      @config.fetch('quiet', false)
    end

    def quiet!
      @config['quiet'] = true
    end

    private

    def merge_config(config_file)
      @config.merge!(YAML.load_file(config_file)) { |_k, old, new| old.merge!(new) } unless @config.empty?
    end
  end
end
