# frozen_string_literal: true

require 'uri'
require 'json'

module SlackWebhookLogger
  class RequestIO
    def self.close
      true
    end

    def self.write(payload)
      return if payload.blank?

      req = Net::HTTP::Post.new(SlackWebhookLogger.webhook_uri.path)
      req.set_form_data(payload: payload.to_json)
      SlackWebhookLogger.https.request(req)
    end
  end
end
