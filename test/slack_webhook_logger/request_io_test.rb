# frozen_string_literal: true

require 'test_helper'

class SlackWebhookLogger::RequestIOTest < Minitest::Test
  def setup
    @title = '🛑 *ERROR*'
    text = 'Some kind of error.'
    @msg = SlackWebhookLogger::Formatter.new.slackify(@title, text)
  end

  def test_it_posts_to_slack
    SlackWebhookLogger.setup do |config|
      config.webhook_url = 'https://hooks.slack.com/services/xxx/yyy/zzz'
    end

    stub_request(:post, 'https://hooks.slack.com/services/xxx/yyy/zzz')
      .with(
        body: { 'payload' => '{"text":"🛑 *ERROR*\\nSome kind of error.","blocks":[{"type":"section","text":{"type":"mrkdwn","text":"🛑 *ERROR*"}},{"type":"divider"},{"type":"section","text":{"type":"plain_text","text":"Some kind of error."}}]}' },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '', headers: {})

    SlackWebhookLogger::RequestIO.write(@msg)
  end

  def test_it_ignores_patterns
    SlackWebhookLogger.setup do |config|
      config.webhook_url = 'https://hooks.slack.com/services/xxx/yyy/zzz'

      config.ignore_patterns = [
        /everything is on fire!/
      ]
    end

    text = 'My goodness! It seems that everything is on fire!!'

    msg = SlackWebhookLogger::Formatter.new.slackify(@title, text)

    # no webmock stub necessary as nothing is sent
    SlackWebhookLogger::RequestIO.write(msg)
  end
end
