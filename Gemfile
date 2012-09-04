source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'simple_form'
gem 'pg'
gem 'unicorn'
gem 'foreman'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test, :travisci do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
end

group :test, :travisci do
  gem 'shoulda-matchers'
	gem 'faker'
	gem 'capybara'
	gem 'database_cleaner'
	gem 'launchy'
  gem 'simplecov', require: false
end

group :development do
 gem 'pry-rescue'
 gem 'pry-stack_explorer'
end