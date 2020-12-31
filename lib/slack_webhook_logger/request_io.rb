# frozen_string_literal: true

require 'uri'
require 'json'

module SlackWebhookLogger
  class RequestIO
    def self.close
      true
    end

    def self.write(hash)
      return if hash.blank?

      return if SlackWebhookLogger.ignore_patterns.any? { |ignore_pattern| hash[:text].match(ignore_pattern) }

      payload = hash.to_json

      req = Net::HTTP::Post.new(SlackWebhookLogger.webhook_uri.path)
      req.set_form_data(payload: payload)
      SlackWebhookLogger.https.request(req)
    end
  end
end
