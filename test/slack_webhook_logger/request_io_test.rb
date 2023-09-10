# frozen_string_literal: true

require "test_helper"

module SlackWebhookLogger
  class RequestIOTest < Minitest::Test
    def setup
      @title = "🛑 *ERROR*"
      @text = "Some kind of error."
      @msg = SlackWebhookLogger::Formatter.new.slackify(@title, @text)
      SlackWebhookLogger.application_name = "TestApp"
    end

    def test_it_posts_to_slack
      SlackWebhookLogger.setup do |config|
        config.webhook_url = "https://hooks.slack.com/services/xxx/yyy/zzz"
      end

      stub_request(:post, "https://hooks.slack.com/services/xxx/yyy/zzz")
        .with(
          body: {
            blocks: [
              {
                type: "section",
                text: {
                  type: "mrkdwn",
                  text: @title,
                },
              },
              {
                type: "divider",
              },
              {
                type: "section",
                text: {
                  type: "mrkdwn",
                  text: @text,
                },
              },
            ],
          }.to_json,
        )
        .to_return(status: 200, body: "", headers: {})

      SlackWebhookLogger::RequestIO.write(@msg)
    end

    def test_it_ignores_patterns
      SlackWebhookLogger.setup do |config|
        config.webhook_url = "https://hooks.slack.com/services/xxx/yyy/zzz"

        config.ignore_patterns = [
          /everything is on fire!/,
        ]
      end

      text = "My goodness! It seems that everything is on fire!!"

      msg = SlackWebhookLogger::Formatter.new.slackify(@title, text)

      # no webmock stub necessary as nothing is sent
      SlackWebhookLogger::RequestIO.write(msg)
    end

    def test_it_recovers_from_invalid_uri
      assert_raises(ArgumentError) do
        SlackWebhookLogger.setup do |config|
          config.webhook_url = nil
        end
      end
    end

    def test_it_warns_on_error
      SlackWebhookLogger.setup do |config|
        config.webhook_url = "https://hooks.slack.com/services/xxx/yyy/zzz"
      end

      stub_request(:post, "https://hooks.slack.com/services/xxx/yyy/zzz")
        .with(
          body: {},
        )
        .to_return(status: 500, body: "", headers: {})

      Warning.expects(:warn)
      SlackWebhookLogger::RequestIO.write(@msg)
    end
  end
end
