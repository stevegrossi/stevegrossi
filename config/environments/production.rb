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
  config.serve_static_files = true
  config.static_cache_control = "public, max-age=31536000"

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = nil

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { host: "www.stevegrossi.com" }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Compress Javascripts and CSS
  config.assets.js_compressor  = :uglifier
  config.assets.css_compressor = :sass

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false
  config.assets.precompile += %w(meta.js meta.css)

  # Generate digests for asset URLs
  config.assets.digest = true

  config.log_level = :info

end
