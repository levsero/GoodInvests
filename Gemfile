source 'https://rubygems.org'

gem 'rails', '4.2.0'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bcrypt'
gem 'addressable', '~> 2.3.7', require: 'addressable/uri'
gem 'rest-client', require: 'rest-client'

gem "figaro"
gem "paperclip", "~> 4.2"
gem 'aws-sdk', '< 2.0'

gem 'pg_search'
gem 'kaminari'

gem 'backbone-on-rails'

gem 'faker'
gem 'better_errors'
gem 'binding_of_caller'
gem 'sinatra'
gem "omniauth-google-oauth2"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem "shoulda-matchers"
  gem 'guard-rspec'
end

# Add to Gemfile
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'quiet_assets'
end

group :production do
  gem 'rails_12factor'
end
