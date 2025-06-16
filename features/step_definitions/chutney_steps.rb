# frozen_string_literal: true

Given('chutney is configured with the linter {string}') do |linter_name|
  @chutney = Chutney::ChutneyLint.new
  @linter_name = linter_name
  linter = Object.const_get(@linter_name)
  linter.reset if linter.respond_to? :reset
  @chutney.linters = linter
  @chutney.configuration.quiet!
end

And('has the settings:') do |settings|
  @chutney.configuration = YAML.safe_load(settings)
end

Given('a feature file called {string} contains:') do |filename, feature_text|
  @feature_file = temporary_file(filename, feature_text)
end

Given('a feature file contains:') do |feature_text|
  @feature_file = temporary_file(nil, feature_text)
end

When('I run Chutney') do
  @chutney << @feature_file.path
end

Then('{int} issue(s) is/are raised') do |expected_number_of_issues|
  @result = @chutney.analyse[@feature_file.path].first
  expect(@result[:linter]).to eq @linter_name.split('::').last
  expect(@result[:issues]&.count).to eq expected_number_of_issues if expected_number_of_issues.positive?
  expect(@result[:issues]&.count).to eq 0 if expected_number_of_issues.zero?
end

Then('the message is:') do |message|
  @result[:issues].each { |i| expect(i[:message]).to eq message }
end

Then('it is reported on:') do |table|
  locations = @result[:issues].map { |i| i[:location] }
  table.symbolic_hashes.each do |row|
    expect(locations).to include(line: row[:line].to_i, column: row[:column].to_i)
  end
end
