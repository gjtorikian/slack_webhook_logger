# frozen_string_literal: true

module SlackWebhookLogger
  class Formatter < ::Logger::Formatter
    attr_writer :format

    MAX_LENGTH = 3000

    class << self
      def fetch_text(hash)
        hash[:blocks].last[:text][:text]
      end
    end

    def format
      @format ||= proc do |severity, time, _progname, msg|
        heading = case severity
        when "FATAL"
          "📛 *#{severity}*"
        when "ERROR"
          "🛑 *#{severity}*"
        when "WARN"
          "⚠️ *#{severity}*"
        when "INFO"
          "ℹ️ *#{severity}*"
        when "DEBUG"
          "🐛 *#{severity}*"
        else
          "🪵 *Logger*"
        end

        title = "#{heading} #{SlackWebhookLogger.application_name} [#{ENV.fetch("RAILS_ENV", nil)}] (#{time})"

        text = <<~MSG
          ```
          #{msg2str(msg)}
        MSG

        slackify(truncate(title), "#{truncate(text)}```")
      end
    end

    def call(severity, time, progname, msg)
      format.call(severity, time, progname, msg)
    end

    def slackify(title, text)
      {
        blocks: [
          {
            type: "section",
            text: {
              type: "mrkdwn",
              text: title,
            },
          },
          {
            type: "divider",
          },
          {
            type: "section",
            text: {
              type: "plain_text",
              text: text,
            },
          },
        ],
      }
    end

    private def msg2str(msg)
      case msg
      when ::String
        msg
      when ::Exception
        "#{msg.message} (#{msg.class})\n" <<
          (msg.backtrace || []).join("\n")
      else
        msg.inspect
      end
    end

    private def truncate(string)
      # 3 for the ellipsis, 3 for the backticks
      string.length > MAX_LENGTH ? "#{string[0...MAX_LENGTH - 6]}..." : string
    end
  end
end
