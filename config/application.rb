# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
# Pick the frameworks you want:

# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module SinceCo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators.template_engine = :slim
    config.time_zone = 'Tokyo'
    config.i18n.default_locale = :ja

    # config.assets.paths << config.root.join('node_modules')

    # config.eager_load_paths.push("#{config.root}/app/apis")

    # 以下二行を追加。やっていることはpathの追加とautoloadの設定
    config.paths.add File.join('app', 'apis'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'apis', '*')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
