source 'https://rubygems.org'

gem 'rails', '4.2.0'

# Use postgresql as the database for Active Record
gem 'pg'
gem 'puma'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'therubyracer'

gem 'bcrypt'
gem 'addressable', '~> 2.3.7', require: 'addressable/uri'
gem 'rest-client', require: 'rest-client'

gem "figaro"
gem "paperclip", "~> 4.2"
gem 'aws-sdk'

gem 'pg_search'
gem 'kaminari'

gem 'backbone-on-rails'

gem 'faker'

gem 'sinatra'
gem "omniauth-google-oauth2"
gem 'omniauth-github', '~> 1.1.2'
gem 'omniauth-facebook'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "letter_opener"
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "factory_girl_rails", "~> 4.0"

  gem 'capybara'
  gem "jasmine"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
end

group :development do
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'rspec-rails'
end

group :test do
  gem "shoulda-matchers"
  gem 'guard-rspec'
end

group :production do
  # gem 'rails_12factor'
end
