require 'bundler/setup'
require 'roda'
require 'sequel'

RSpec.configure do |config|
  config.expect_with :rspec
  config.mock_with :rspec
  config.include_chain_clauses_in_custom_matcher_descriptions = true
  config.syntax = :expect

  config.color = true
  config.profile = 10
  config.warnings = false

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run_when_matching :focus
  config.order = :random
  Kernel.srand config.seed

  config.filter_run :focus
  config.default_formatter = 'doc'

  config.define_derived_metadata(file_path: %r{/spec/}) do |metadata|
    metadata[:aggregate_failures] = true
  end

  config.before(:suite) do
    DB = Sequel.connect('sqlite::memory:')
  end

  config.around(:each) do |example|
    DB.transaction do
      example.run
      raise Sequel::Rollback
    end
  end
end
