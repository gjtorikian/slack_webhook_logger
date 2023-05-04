# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'

module SlackWebhookLogger
  class Logger < ::ActiveSupport::Logger
    class << self
      delegate :fatal, :error, :warn, :info, :debug,
               :add, :log, to: :instance
    end
  end
end
