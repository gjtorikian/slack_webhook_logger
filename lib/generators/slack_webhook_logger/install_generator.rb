# frozen_string_literal: true

require 'rails/generators/base'

module SlackWebhookLogger
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("..#{File::SEPARATOR}..#{File::SEPARATOR}templates", __FILE__)

    desc 'Create a Slack::WebhookLogger initializer'

    def copy_initializer
      template 'slack_webhook_logger.rb', 'config/initializers/slack_webhook_logger.rb'
    end
  end
end
