require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(:default, Rails.env)

module Stevegrossi
  class Application < Rails::Application

    # Configure generators for testing
    config.generators do |g|
      g.test_framework :rspec,
      fixtures: true,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: true,
      request_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/app/models/concerns)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Handle routing or errors meself
    config.exceptions_app = self.routes

    # Use dalli/memcached
    config.cache_store = :dalli_store

    # Remove trailing slashes from URLs
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 %r{^/(.*)/$}, '/$1'
    end

  end
end
