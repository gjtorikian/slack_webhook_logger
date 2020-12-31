# Slack::WebhookLogger

A simple Slack logger using ActiveSupport broadcast and a slim HTTPS call.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack-webhooklogger'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install slack-webhooklogger
```

Then, run the install generator:

```
$ rails generate slack-webhooklogger:install
```

Provide the webhook URL in the config, and finally, extend the logger:

```ruby
config.after_initialize do
  Rails.logger.extend ActiveSupport::Logger.broadcast(SlackWebhookLogger.logger)
end
```

## Configuration

You can change the log level or the format of the logging text if you wish. See the generated slack_webhook_logger.rb file for more information on that.
