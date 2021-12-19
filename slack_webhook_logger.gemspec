# frozen_string_literal: true

require_relative 'lib/slack_webhook_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_webhook_logger'
  spec.version       = SlackWebhookLogger::VERSION
  spec.authors       = ['Garen J. Torikian']
  spec.email         = ['gjtorikian@gmail.com']

  spec.summary       = 'A slim wrapper for posting to Rails logs to Slack'
  spec.homepage      = 'https://github.com/gjtorikian/slack_webhook_logger'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('~> 3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 5.0', '< 7.0'
  spec.add_dependency 'railties', '>= 5.0', '< 7.0' # for the generators
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
