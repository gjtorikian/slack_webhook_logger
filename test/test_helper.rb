# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

if ENV.fetch("DEBUG", false)
  require "amazing_print"
  require "debug"
end

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "slack_webhook_logger"
require "rails/generators/test_case"
require "generators/slack_webhook_logger/install_generator"

require "minitest/autorun"
require "minitest/pride"

require "webmock/minitest"
require "httpx/adapters/webmock"
WebMock.enable!
WebMock.disable_net_connect!(allow_localhost: true)

WebMock.disable_net_connect!

require "mocha/minitest"
