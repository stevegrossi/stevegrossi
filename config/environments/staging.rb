Stevegrossi::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled
  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  # Serve static assets with far-future expires headers
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=2592000"

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = nil

  # Have Unicorn log to STDOUT so full logs are captured
  config.logger = Logger.new(STDOUT)
  config.log_level = :debug

  # Serve static assets, which Rack::cache will cache
  config.serve_static_assets = true

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Compress Javascripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false
  config.assets.precompile += %w(admin.js admin.css)

  # Generate digests for asset URLs
  config.assets.digest = true

end
