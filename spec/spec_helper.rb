require 'simplecov'
require 'capybara/rspec'

# ドライバを設定(デフォルトは:rack_test)
Capybara.default_driver = :rack_test
# jsオプション有効時のドライバを設定(デフォルトは:selenium)
Capybara.javascript_driver = :selenium

SimpleCov.start 'rails'

RSpec.configure do |config|
  config.before(:all) do
    FactoryBot.reload
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
