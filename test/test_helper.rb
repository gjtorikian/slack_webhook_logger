# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'slack_webhook_logger'
require 'rails/generators/test_case'
require 'generators/slack_webhook_logger/install_generator'

require 'minitest/autorun'
