# frozen_string_literal: true

# Disable rubocop checks for the .gemspec
# I'll take the output from 'bundle gem new' to be authoritative
# rubocop:disable all

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chutney/version'

Gem::Specification.new do |spec|
  spec.name        = 'chutney'
  spec.version     = Chutney::VERSION
  spec.authors     = ['Nigel Brookes-Thomas', 'Stefan Rohe', 'Nishtha Argawal', 'John Gluck']
  spec.email       = ['nigel@brookes-thomas.co.uk']

  spec.summary     = 'A linter for multi-lingual Gherkin'
  spec.description = 'A linter for your Cucumber features. '                    \
                     'Making sure you have nice, expressible Gherkin is '       \
                     'essential is making sure you have a readable test-base. ' \
                     'Chutney is designed to sniff out smells in your feature ' \
                     'files. '                                                  \
                     'It supports any spoken language Cucumber supports.'

  spec.homepage    = 'https://billyruffian.github.io/chutney/'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = 'TODO: Set to 'http://mygemserver.com''

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/BillyRuffian/chutney'
    spec.metadata['changelog_uri'] = 'https://github.com/BillyRuffian/chutney/releases'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|s|features)/}) }
  end
  
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  
  spec.add_runtime_dependency 'amatch', '~> 0.4.0'
  spec.add_runtime_dependency 'cuke_modeler', '~> 3.3'
  spec.add_runtime_dependency 'i18n', '~> 1.8.2'
  spec.add_runtime_dependency 'pastel', '~> 0.7'
  spec.add_runtime_dependency 'tty-pie', '~> 0.3'


  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'cucumber', '~> 6.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rerun', '~> 0.13'
  spec.add_development_dependency 'rspec-expectations', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.18.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  
  spec.required_ruby_version = '>= 2.6'
end
