require 'date'
require 'time'

module TimeReceive
  class TimeReceiveError < StandardError; end

  class TimeFormatter
    def initialize(format_string)
      @format_string = format_string
    end

    def format(time)
      raise TimeReceiveError, "Invalid time: #{time}" unless time.is_a?(Time)
      time.strftime(@format_string) # Используйте strftime для форматирования времени
    end
  end

  module ClassMethods
    def now(format_string = nil)
      formatter = format_string ? TimeFormatter.new(format_string) : TimeFormatter.new("%Y-%m-%d %H:%M:%S")
      formatter.format(Time.now)
    end

    def parse_time(time_string, format_string)
      begin
        Time.strptime(time_string, format_string)
      rescue ArgumentError
        raise TimeReceiveError, "Invalid time string: #{time_string}"
      end
    end
  end

  self.extend ClassMethods
end
