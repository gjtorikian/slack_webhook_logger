# frozen_string_literal: true

require "uri"
require "json"
require "httpx"

module SlackWebhookLogger
  class RequestIO
    class << self
      def close
        true
      end

      def write(hash)
        return if hash.blank?

        return if SlackWebhookLogger.ignore_patterns.any? { |ignore_pattern| hash[:text].match(ignore_pattern) }

        response = HTTPX.with(headers: { "content-type" => "application/json" }).post(SlackWebhookLogger.webhook_uri.to_s, json: hash)

        return if (200..299).cover?(response.status)

        error_prefix = "slack_webhook_logger failed.\nRequest: #{hash}\nResponse:"
        case response
        when HTTPX::ErrorResponse
          warn("#{error_prefix} #{response}")
        else
          warn("#{error_prefix} #{response.status} #{response.body}")
        end
      end
    end
  end
end
