# frozen_string_literal: true

# require 'dotenv/load'
require "simplecov"
# require 'webmock/rspec'
require "time_receive"

SimpleCov.start "rails" do
  if ENV["CI"]
    require "simplecov-lcov"

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = "coverage/lcov.info"
    end

    formatter SimpleCov::Formatter::LcovFormatter
  end

  add_filter "spec/"
  add_filter ".github/"
  add_filter "lib/generators/templates/"
  add_filter "lib/lokalise_rails/version.rb"
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
ENV["RAILS_ENV"] = "test"
require_relative "../spec/dummy/config/environment"
ENV["RAILS_ROOT"] ||= "#{File.dirname(__FILE__)}../../../spec/dummy"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
