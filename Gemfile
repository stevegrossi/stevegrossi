source 'http://rubygems.org'
ruby '2.2.1'

gem 'rails', '~> 4.2.1'
gem 'actionpack-action_caching'
gem 'rails-observers'
gem 'maruku'
gem 'friendly_id', '~> 5.0'
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'kaminari'
gem 'devise'

# Database
gem 'pg'
gem 'pg_search'

# App Server
gem 'unicorn'
gem 'rack-rewrite'
gem 'rack-canonical-host'

# Memcache
gem 'dalli'

# Assets and templating
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'slim'
gem 'turbolinks'

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.2'
end

group :development do
  gem 'foreman'
  gem 'annotate'
  gem 'bullet'
  gem 'meta_request'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'coveralls', require: false
end
