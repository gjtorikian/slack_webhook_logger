# frozen_string_literal: true

module SlackWebhookLogger
  class Formatter < ::Logger::Formatter
    attr_writer :format

    def format
      @format ||= proc do |severity, time, _progname, msg|
        heading = case severity
                  when 'FATAL'
                    "📛 *#{severity}*"
                  when 'ERROR'
                    "🛑 *#{severity}*"
                  when 'WARN'
                    "⚠️ *#{severity}*"
                  when 'INFO'
                    "ℹ️ *#{severity}*"
                  when 'DEBUG'
                    "🐛 *#{severity}*"
                  else
                    '🪵 *Logger*'
                  end

        title = "#{heading} (#{time}) [#{ENV['RAILS_ENV']}]"

        text = <<~MSG
          #{msg2str(msg)}
        MSG

        slackify(title, text)
      end
    end

    def call(severity, time, progname, msg)
      format.call(severity, time, progname, msg)
    end

    def slackify(title, text)
      {
        text: [title, text].join("\n").to_s,
        blocks: [
          {
            type: 'section',
            text: {
              type: 'mrkdwn',
              text: title
            }
          },
          {
            type: 'divider'
          },
          {
            type: 'section',
            text: {
              type: 'plain_text',
              text: text
            }
          }
        ]
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
  end
end
