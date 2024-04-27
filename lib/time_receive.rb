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

      hours_str = hours.to_s.rjust(2, '0')
      minutes_str = minutes.to_s.rjust(2, '0')
      seconds_str = seconds.to_s.rjust(2, '0')

      "#{hours_str}:#{minutes_str}:#{seconds_str}"
    end

    def today?
      Date.today == Time.now.to_date
    end

    def days_until(target_date)
      raise ArgumentError, "Invalid target_date: #{target_date}" unless target_date.is_a?(Date)
      (target_date - Date.today).to_i
    end

    def add_time_period(time, period)
      raise ArgumentError, "Invalid time: #{time}" unless time.is_a?(Time)

      case period
      when :hours
        time + 3600
      when :minutes
        time + 60
      when :days
        time + 86400
      else
        raise ArgumentError, "Unsupported period: #{period}"
      end
    end

    def calculate_elapsed_time(start_time, end_time)
      raise ArgumentError, "Invalid start_time: #{start_time}" unless start_time.is_a?(Time)
      raise ArgumentError, "Invalid end_time: #{end_time}" unless end_time.is_a?(Time)

      elapsed_seconds = (end_time - start_time).to_i
      hours = elapsed_seconds / 3600
      minutes = (elapsed_seconds % 3600) / 60

      "#{hours} hours and #{minutes} minutes"
    end
  end

  extend ClassMethods
end
