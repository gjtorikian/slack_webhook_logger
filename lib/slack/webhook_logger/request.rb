# frozen_string_literal: true

module Rails
  module Logger
    class Slack
      class Request
        # See https://api.slack.com/methods/chat.postMessage for more details
        VALID_OPTIONS = {
          # Channel, private group, or IM channel to send message to. Can be an encoded ID, or a name.
          channel: String,
          # How this field works and whether it is required depends on other fields you use in your API call.
          text: String,
          # Pass true to post the message as the authed user, instead of as a bot.
          as_user: Boolean,
          # A JSON-based array of structured attachments, presented as a URL-encoded string.
          attachments: String,
          # Emoji to use as the icon for this message.
          icon_emoji: String,
          # Find and link channel names and usernames.
          link_names: Boolean,
          # Disable Slack markup parsing by setting to false.
          mrkdwn: Boolean,
          # Change how messages are treated.
          parse: String,
          # Used in conjunction with thread_ts and indicates whether reply should be made visible to everyone in the channel or conversation.
          reply_broadcast: Boolean,
          # Provide another message's ts value to make this message a reply.
          thread_ts: String,
          # Pass true to enable unfurling of primarily text-based content.
          unfurl_links: Boolean
          # Pass false to disable unfurling of media content.
          unfurl_media: Boolean,
          # Set your bot's user name.
          username: String
        }.freeze

        attr_reader(*VALID_OPTIONS)
      end
    end
  end
end
