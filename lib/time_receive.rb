# frozen_string_literal: true

require_relative "time_receive/version"

module TimeReceive
  require 'date'
  require 'time'

  def self.now(format_string = nil)
    formatter = format_string ? TimeFormatter.new(format_string) : TimeFormatter.new("%Y-%m-%d %H:%M:%S")
    formatter.format(Time.now)
  end

  def self.parse_time(time_string, format_string)
    begin
      Time.strptime(time_string, format_string)
    rescue ArgumentError
      raise TimeReceive::Error, "Invalid time string: #{time_string}"
    end
  end

  class TimeFormatter
    def initialize(format_string)
      @format_string = format_string
    end

    def format(time)
      raise TimeReceive::Error, "Invalid time: #{time}" unless time.is_a?(Time)
      @format_string % time
    end
  end
end
