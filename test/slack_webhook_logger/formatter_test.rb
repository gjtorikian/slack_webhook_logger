# frozen_string_literal: true

require "test_helper"

module SlackWebhookLogger
  class FormatterTest < Minitest::Test
    def setup
      @formatter = SlackWebhookLogger::Formatter
    end

    def test_default_format
      assert(@formatter.new.call(:ERROR, Time.now.to_i, "Tester", "Failed"))
    end

    def test_changed_format
      formatter = @formatter.new
      formatter.format = -> { "wakka wakka" }

      assert_equal("wakka wakka", formatter.format.call)
    end

    def test_truncates
      formatter = @formatter.new

      assert_match(
        /wakkawa\.\.\./,
        formatter.format.call("severity", "timestamp", "progname", "wakka wakka" * Formatter::MAX_LENGTH)[:text],
      )
    end
  end
end
