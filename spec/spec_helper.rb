# frozen_string_literal: true

require 'bundler/setup'
require 'apogee'
require 'simplecov'

SimpleCov.start

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each do |f|
  require_relative f
end

RSpec.configure do |config|
  config.include RSpecHelpers

  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
