Recaptcha.configure do |config|
  recaptcha_config = YAML.load_file("#{Rails.root}/config/recaptcha.yml")
  config.public_key  = recaptcha_config['public_key']
  config.private_key = recaptcha_config['private_key']
end