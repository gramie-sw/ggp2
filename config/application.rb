require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Ggp2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib/validators)
    config.autoload_paths += Dir["#{config.root}/app/domain/**/"]
    config.autoload_paths += Dir["#{config.root}/app/models/**/"]
    config.autoload_paths += Dir["#{config.root}/app/plugins/**/"]
    config.autoload_paths += Dir["#{config.root}/app/presenters/**/"]
    config.autoload_paths += Dir["#{config.root}/app/services/**/"]
    config.autoload_paths += Dir["#{config.root}/app/use_cases/**/"]
    config.autoload_paths += Dir["#{config.root}/app/repositories/**/"]

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.available_locales = [:en, :de]
    config.i18n.default_locale = :de
    config.i18n.fallbacks = [:en]
    I18n.config.enforce_available_locales = true

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
    config.time_zone = 'Berlin'
    config.active_record.default_timezone = :local

    #loads instance configuration from config/instance_config.yml
    YAML.load_file("#{Rails.root}/config/instance_config.yml").each do |k, v|
      config.send "#{k}=", v
    end

    config.application_version = YAML.load_file("#{Rails.root}/config/version.yml")['version']

    #needed for devise
    config.action_mailer.default_url_options = {host: config.toplevel_domain}
    config.action_mailer.default_options = {from: config.sender_email}

    config.quotations_file = "#{Rails.root}/config/quotations.yml"
    config.badges_file = "#{Rails.root}/config/badges.yml"
    config.color_codes_file = "#{Rails.root}/config/color_codes.yml"
  end

  USER_TIPS_LAST_SHOWN_AGGREGATE_ID_KEY = 'utlscaid'

  AuthorizationFailedError = Class.new StandardError

  def self.config
    Application.config
  end
end
