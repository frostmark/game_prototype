require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGameServer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.eager_load_paths << "#{Rails.root}/lib"

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # In development, we don't care about the origin.
        origins '*'
        # Reminder: On the following line, the 'methods' refer to the 'Access-
        # Control-Request-Method', not the normal Request Method.
        resource '*'
      end
    end
  end
end
