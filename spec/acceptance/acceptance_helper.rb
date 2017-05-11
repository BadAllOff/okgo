require 'rails_helper'

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature
  # config.include AcceptanceMacros, type: :feature

  config.use_transactional_fixtures = false

  Capybara.default_max_wait_time = 5

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # config.before(:each) do
  #   DatabaseCleaner.strategy = :transaction
  # end
  #
  # config.before(:each) do
  #   DatabaseCleaner.start
  # end
  #
  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

end