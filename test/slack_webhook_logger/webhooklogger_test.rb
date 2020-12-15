# frozen_string_literal: true

require 'test_helper'

class SlackWebhookLoggerTest < Minitest::Test
  def test_initialization
    assert_respond_to SlackWebhookLogger, :webhook_url
  end
end
