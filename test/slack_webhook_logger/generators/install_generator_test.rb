# frozen_string_literal: true

class InstallGeneratorTest < Rails::Generators::TestCase
  tests SlackWebhookLogger::InstallGenerator
  destination File.expand_path("..#{File::SEPARATOR}tmp", File.dirname(__FILE__))
  setup :prepare_destination

  def test_all_factors
    run_generator

    assert_file("config/initializers/slack_webhook_logger.rb")
  end
end
