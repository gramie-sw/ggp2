Recaptcha.configure do |config|
  config.public_key  = YAML.load_file("#{Rails.root}/config/recaptcha.yml")['public_key']
  config.private_key = YAML.load_file("#{Rails.root}/config/recaptcha.yml")['private_key']
end