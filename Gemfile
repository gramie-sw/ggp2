source 'https://rubygems.org'

gem 'rails', '~> 4.1.1'
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

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-fire'
  gem 'guard-rspec'
end

group :development do
  gem 'letter_opener'
  gem 'meta_request'
  gem "pry-rails", "~> 0.3.2"
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec', require: false

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
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