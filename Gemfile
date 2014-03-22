source 'http://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.0.rc1'
gem 'actionpack-action_caching'
gem 'rails-observers'
gem 'maruku'
gem 'friendly_id', github: 'norman/friendly_id' # 5.0.0, for Rails 4
gem 'simple_form'
gem 'kaminari'
gem 'devise'
gem 'thread_safe', '0.2.0'

# Database
gem 'pg'
gem 'pg_search'

# App Server
gem 'unicorn'
gem 'foreman'
gem 'rack-rewrite'

# Memcache
gem 'memcachier'
gem 'dalli'

gem 'jquery-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails'
gem 'uglifier'
gem 'slim'

# Deployment
gem 'rails_12factor', group: [:staging, :production]
gem 'newrelic_rpm'

group :development, :test do
  gem 'rspec-rails', '~> 2.5'
  gem 'factory_girl_rails'
end

group :development do
  gem 'annotate'
  # gem 'bullet'
  gem 'meta_request'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'faker'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'coveralls', require: false
end
