# Slack::WebhookLogger

A simple Slack logger using ActiveSupport broadcast and a slim HTTPS call.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_webhook_logger'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install slack_webhook_logger
```

Then, run the install generator:

```
$ rails generate slack_webhook_logger:install
```

Provide the webhook URL in the config, and finally, extend the logger:

```ruby
config.after_initialize do
  Rails.logger.extend ActiveSupport::Logger.broadcast(SlackWebhookLogger.logger)
end
```

## Configuration

You should have a file in `config/initializers/slack_webhook_logger.rb` that looks something like this:

```ruby
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
```

You can change the log level or the format of the logging text if you wish. See the generated slack_webhook_logger.rb file for more information on that.
