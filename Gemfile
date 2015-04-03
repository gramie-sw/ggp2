source 'https://rubygems.org'

gem 'rails', '~> 4.2.1'
gem 'actionmailer'
gem 'jbuilder'
gem 'mysql2'
gem 'puma'

gem 'slim'
gem 'sass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'uglifier'
gem 'therubyracer', platforms: :ruby

gem 'rails-i18n'
gem 'localized_country_select'

gem 'ancestry'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'devise'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'permissioner'

gem 'transpec'

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener'
  gem 'meta_request'
  gem 'pry-rails'
  gem 'quiet_assets'
  
  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'spring'
  gem 'spring-commands-rspec', require: false

  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano3-puma', require: false

  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  # require false necessary to remove minitest warning
  #see https://github.com/rspec/rspec-rails/pull/772
  gem 'shoulda-matchers'
  gem 'forgery'
end


group :doc do
  gem 'sdoc', require: false
end