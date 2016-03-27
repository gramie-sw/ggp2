# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'permissioner/matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  Dir[Rails.root.join("spec/roles/**/*.rb")].each { |f| require f }

  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  if defined?(Spring)
    config.seed = rand(50000)
  else
    config.order= "random"
  end

  config.include Devise::TestHelpers, type: :controller
  config.include ControllerMacros, :type => :controller
  # config.include(EmailSpec::Helpers)
  # config.include(EmailSpec::Matchers)
  config.include FactoryGirl::Syntax::Methods
  config.include ControllerMacros, type: :controller
  config.include ActionView::Helpers::TranslationHelper
  config.include Permissioner::Matchers

# rspec-rails 3 will no longer automatically infer an example group's spec type
# from the file location. You can explicitly opt-in to this feature using this
# snippet:
  config.infer_spec_type_from_file_location!

  config.include(Shoulda::Matchers::ActiveModel)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end