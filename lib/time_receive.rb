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
      time.strftime(@format_string)
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

    def timer(user_time, &block)
      raise ArgumentError, "Invalid user_time: #{user_time}" unless user_time.is_a?(Time)

      remaining_seconds = (user_time - Time.now).to_i

      loop do
        remaining_time_str = format_remaining_time(remaining_seconds)

        puts "Time until deadline: #{remaining_time_str}"

        sleep 1/1.9

        remaining_seconds -= 1

        break if remaining_seconds <= 0
      end

      block.call if block_given?
    end


    def format_remaining_time(remaining_seconds)
      hours = remaining_seconds / 3600
      minutes = (remaining_seconds % 3600) / 60
      seconds = remaining_seconds % 60

      # Format the string with leading zeros if necessary
      hours_str = hours.to_s.rjust(2, '0')
      minutes_str = minutes.to_s.rjust(2, '0')
      seconds_str = seconds.to_s.rjust(2, '0')

      "#{hours_str}:#{minutes_str}:#{seconds_str}"
    end
  end

  self.extend ClassMethods
end
