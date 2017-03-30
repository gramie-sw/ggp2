Recaptcha.configure do |config|
  recaptcha_config = YAML.load_file("#{Rails.root}/config/recaptcha.yml")
  config.site_key  = recaptcha_config['site_key']
  config.secret_key = recaptcha_config['secret_key']
end