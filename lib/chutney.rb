# frozen_string_literal: true

require 'amatch'

require 'chutney/configuration'
require 'chutney/linter'
require 'chutney/linter/avoid_full_stop'
require 'chutney/linter/avoid_outline_for_single_example'
require 'chutney/linter/avoid_scripting'
require 'chutney/linter/avoid_splat_steps_in_background'
require 'chutney/linter/avoid_splat_steps_in_scenarios'
require 'chutney/linter/avoid_typographers_quotes'
require 'chutney/linter/background_does_more_than_setup'
require 'chutney/linter/background_requires_multiple_scenarios'
require 'chutney/linter/bad_scenario_name'
require 'chutney/linter/empty_feature_file'
require 'chutney/linter/file_name_differs_feature_name'
require 'chutney/linter/givens_after_background'
require 'chutney/linter/invalid_file_name'
require 'chutney/linter/invalid_step_flow'
require 'chutney/linter/missing_example_name'
require 'chutney/linter/missing_example_table'
require 'chutney/linter/missing_feature_description'
require 'chutney/linter/missing_feature_name'
require 'chutney/linter/missing_scenario_name'
require 'chutney/linter/missing_scenario_outline'
require 'chutney/linter/missing_test_action'
require 'chutney/linter/missing_verification'
require 'chutney/linter/required_tags_starts_with'
require 'chutney/linter/same_tag_different_case'
require 'chutney/linter/same_tag_for_all_scenarios'
require 'chutney/linter/scenario_names_match'
require 'chutney/linter/tag_used_multiple_times'
require 'chutney/linter/too_clumsy'
require 'chutney/linter/too_long_step'
require 'chutney/linter/too_many_different_tags'
require 'chutney/linter/too_many_steps'
require 'chutney/linter/too_many_tags'
require 'chutney/linter/unique_scenario_names'
require 'chutney/linter/unknown_variable'
require 'chutney/linter/unused_variable'
require 'chutney/linter/use_background'
require 'chutney/linter/use_outline'
require 'chutney/locator'
require 'chutney/version'

require 'cuke_modeler'
require 'forwardable'
# require 'gherkin/dialect'
# require 'gherkin/parser'
require 'i18n'
require 'set'
require 'yaml'

module Chutney
  class UnsupportedCucumberError < StandardError; end

  # gherkin linter
  class ChutneyLint
    extend Forwardable
    attr_accessor :verbose
    attr_reader :files, :results

    def_delegators :@files, :<<, :clear, :delete, :include?

    def initialize(*files)
      @files = files
      @results = Hash.new { |h, k| h[k] = [] }
      i18n_paths = Dir[File.expand_path(File.join(__dir__, 'config/locales')) + '/*.yml']

      i18n_paths.each do |path|
        next if I18n.load_path.include?(path)

        I18n.load_path << path
        I18n.backend.reload!
      end
    end

    def configuration
      unless @config
        default_file = [File.expand_path('..', __dir__), '**/config', 'chutney_defaults.yml']
        config_file = Dir.glob(File.join(default_file)).first.freeze
        @config = Configuration.new(config_file)
      end
      @config
    end

    def configuration=(config)
      @config = config
    end

    def analyse
      files.each do |f|
        lint(f)
      end
      @results
    end
    # alias for non-british English
    # https://dictionary.cambridge.org/dictionary/english/analyse
    alias analyze analyse

    def linters
      @linters ||= Linter.descendants.filter { |l| configuration.dig(l.linter_name, 'Enabled') }
    end

    def linters=(*linters)
      @linters = linters
    end

    private

    def lint(file)
      parsed = CukeModeler::FeatureFile.new(file)
      linters.each do |linter_class|
        linter = linter_class.new(file, parsed, configuration[linter_class.linter_name])
        linter.lint
        @results[file] << { linter: linter.linter_name, issues: linter.issues }
      end
    end
  end
end
