# frozen_string_literal: true

require 'active_support/logger'
require 'active_support/core_ext/module/attribute_accessors'

require 'net/http'
require 'net/https'
require 'uri'

require 'slack_webhook_logger/logger'
require 'slack_webhook_logger/formatter'
require 'slack_webhook_logger/request_io'

module SlackWebhookLogger
  # Can be modified in Rails app
  mattr_accessor :webhook_url
  mattr_accessor :level
  mattr_accessor :formatter
  mattr_accessor :ignore_patterns

  # Used internally
  mattr_reader :webhook_uri
  mattr_reader :logger
  mattr_reader :https

  # rubocop:disable Style/ClassVars
  def self.setup
    @@logger = SlackWebhookLogger::Logger.new(SlackWebhookLogger::RequestIO)

    yield self

    @@logger.formatter = @@formatter || SlackWebhookLogger::Formatter.new
    @@logger.level = @@level || :warn

    @@webhook_uri = URI.parse(@@webhook_url)
    https = Net::HTTP.new(@@webhook_uri.host, @@webhook_uri.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER

    @@https = https

    @@ignore_patterns ||= []
  end
  # rubocop:enable Style/ClassVars
end
