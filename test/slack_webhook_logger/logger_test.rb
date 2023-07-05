# frozen_string_literal: true

require "test_helper"

module SlackWebhookLogger
  class LoggerTest < Minitest::Test
    def setup
      @logger = SlackWebhookLogger::Logger.new($stdout)
    end

    def test_initialization
      assert_respond_to(@logger, :fatal)
      assert_respond_to(@logger, :error)
      assert_respond_to(@logger, :warn)
      assert_respond_to(@logger, :info)
      assert_respond_to(@logger, :debug)
      assert_respond_to(@logger, :add)
      assert_respond_to(@logger, :log)
    end
  end
end
