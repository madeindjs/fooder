require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fooder
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded

    # Silent deprecation warning " Time columns will become time zone aware in Rails 5.1"
    config.active_record.time_zone_aware_types = [:datetime, :time]

    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address:              'ssl0.ovh.net',
      port:                 465,
      domain:               'ssl0.ovh.net',
      user_name:            'support@fooder.pro',
      password:             Rails.application.secrets.email_password,
      authentication:       :plain,
      enable_starttls_auto: true ,
      tls: true 
    }
  end
end
