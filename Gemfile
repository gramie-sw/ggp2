source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 4.2.6'
gem 'actionmailer'
gem 'virtus'
gem 'mysql2'
gem 'puma'

gem 'slim'
gem 'sass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'simple_form'
gem 'font-awesome-rails'
gem 'uglifier'

gem 'rails-i18n'
gem 'localized_country_select'

gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'kaminari-bootstrap'

gem 'ancestry'
gem 'kaminari'
gem 'devise'
gem 'recaptcha', :require => 'recaptcha/rails'
gem 'permissioner'

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener_web'
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
  gem 'fuubar'
  gem 'factory_girl_rails'
  # require false necessary to remove minitest warning
  #see https://github.com/rspec/rspec-rails/pull/772
  gem 'forgery'
  gem 'shoulda-matchers'
end


group :doc do
  gem 'sdoc', require: false
end

group :production do
  gem 'therubyracer', platforms: :ruby
end
