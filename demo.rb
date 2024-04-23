# frozen_string_literal: true

require_relative 'lib/time_receive'

current_time = TimeReceive.now
puts "Current time (default format): #{current_time}"

custom_format_time = TimeReceive.now("%Y_%m_%d_%H_%M_%S")
puts "Current time (custom format): #{custom_format_time}"

parsed_time = TimeReceive.parse_time("2024-04-27 15:30:00", "%Y-%m-%d %H:%M:%S")
puts "Parsed time object: #{parsed_time}"

begin
  TimeReceive.parse_time("invalid time format", "%Y-%m-%d %H:%M:%S")
rescue TimeReceive::TimeReceiveError => e
  puts "Error parsing time: #{e.message}"
end
