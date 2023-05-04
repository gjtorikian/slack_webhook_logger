# frozen_string_literal: true

require 'uri'
require 'json'
require 'httpx'

module SlackWebhookLogger
  class RequestIO
    def self.close
      true
    end

    def self.write(hash)
      return if hash.blank?

      return if SlackWebhookLogger.ignore_patterns.any? { |ignore_pattern| hash[:text].match(ignore_pattern) }

      HTTPX.post(SlackWebhookLogger.webhook_uri.to_s, form: hash)
    end
  end
end
