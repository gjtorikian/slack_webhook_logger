# frozen_string_literal: true

SlackWebhookLogger.setup do |config|
  # The URL where messages will be sent. This is required.
  config.webhook_url = 'https://hooks.slack.com/services/xxx/yyy/zzz'

  # The minimum error level to see in Slack. This is optional; the default is :WARN.
  #
  # All log levels are supported, but don't rely on anything less then :WARN
  # since Slack only allows one message per minute.
  # config.level = :WARN

  # You can provide a custom log formatter if you want to. This is optional.
  # The formatter must construct a JSON blob that adheres to Slack's expected
  # POST payload for `chat.postMessage`: https://api.slack.com/methods/chat.postMessage
  # config.formatter =  SomeOtherFormatter.new

  # You can provide an array of regular expressions to ignore certain messages
  # from being sent to Slack. This is optional.
  # config.ignore_patterns = []
end
