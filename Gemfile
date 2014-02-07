source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>4.0.2'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#removed turbolink due to many incompatibilities
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~>1.2'
#gem 'jbuilder', '~> 1.4.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'rails-i18n', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.1.0'
#gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'

gem 'font-awesome-rails', '~> 4.0.3.0'
gem 'localized_country_select', '>= 0.9.7'
gem 'ancestry'

gem 'rspec-rails', '~>2.14.0',  :group => [:test, :development]
gem 'guard-rspec', '~>4.1.1', :group => [:test, :development]
gem 'spring-commands-rspec', require: false, :group => [:test, :development]
gem 'spring', '1.0.0', :group => [:test, :development]

gem 'puma', '~>2.7.1'

group :development do
  gem 'meta_request', '~>0.2.8'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails', '~>4.3.0'
  gem 'shoulda-matchers', '~>2.4.0'
  gem 'forgery'
end