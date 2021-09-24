# frozen_string_literal: true

require 'rake/testtask'

task default: :build

desc 'Builds the Gem.'
task build: :format
task build: :self_check
task build: :test do
  sh 'gem build gherkin_lint.gemspec'
end

# desc 'Publishes the Gem'
# task :push do
#   sh 'gem push gherkin_lint-1.2.2.gem'
# end

desc 'Checks ruby style'
task :rubocop do
  sh 'rubocop -a'
rescue RuntimeError => e
  # Rubocop failing due to style violations is fine. Other errors should bubble up to our attention.
  raise e unless e.message =~ /status \(1\).*rubocop/

  puts 'Rubocop failed'
end

task :spec do
  sh 'bundle exec rspec'
end

task :cucumber do
  sh 'cucumber --tags "not @skip" --guess -f progress'
end

task test: %i[rubocop spec cucumber]
