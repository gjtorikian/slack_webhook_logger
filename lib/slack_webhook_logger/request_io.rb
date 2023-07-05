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

        response = HTTPX.post(SlackWebhookLogger.webhook_uri.to_s, form: hash)

        return if (200..299).cover?(response.status)

        case response
        when HTTPX::ErrorResponse
          warn(response)
        else
          warn(response.body)
        end
      end
    end
  end
end
