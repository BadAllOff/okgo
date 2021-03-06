require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Okgo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| "<span class='field_with_errors'>#{html_tag}</span>".html_safe }
    config.time_zone = 'Asia/Baku'
    config.active_record.default_timezone = :local # Or :utc

    config.i18n.default_locale = :en

    I18n.available_locales = [:ru, :en]

    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:en]

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false,
                       controller_specs: true
      g.fixtures_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
