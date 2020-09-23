# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

require 'chutney'
require 'rspec/expectations'
require 'yaml'

Around do |_scenario, block|
  block.call
  if @feature_file
    @feature_file.close
    @feature_file
  end
end
