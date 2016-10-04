require 'rails/controller/testing/test_process'
require 'rails/controller/testing/integration'
require 'rails/controller/testing/template_assertions'

RSpec.configure do |config|
  config.include Rails::Controller::Testing::TestProcess, type: :controller
  config.include Rails::Controller::Testing::Integration, type: :controller
  config.include Rails::Controller::Testing::TemplateAssertions, type: :controller
end