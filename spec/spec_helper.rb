require 'bundler/setup'
require 'roda'
require 'json'
require_relative '../app/app'

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with :rspec

  config.color = true
  config.warnings = false

  config.run_all_when_everything_filtered = true
  config.filter_run_when_matching :focus
  config.order = :random
  Kernel.srand config.seed

  config.default_formatter = 'doc'

  config.define_derived_metadata(file_path: %r{/spec/}) do |metadata|
    metadata[:aggregate_failures] = true
  end
end
