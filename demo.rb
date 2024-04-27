# frozen_string_literal: true

require_relative "lib/time_receive"

start_time = Time.now
puts "Start time: #{start_time}"

new_time = TimeReceive.add_time_period(start_time, :hours)
puts "Time after adding 1 hour: #{new_time}"

new_time = TimeReceive.add_time_period(start_time, :days)
puts "Time after adding 1 day: #{new_time}"

# Пример использования метода calculate_elapsed_time
start_time = Time.now
puts "Start time: #{start_time}"
sleep 3 # Допустим, что прошло 3 секунды

end_time = Time.now
puts "End time: #{end_time}"

elapsed_time = TimeReceive.calculate_elapsed_time(start_time, end_time)
puts "Elapsed time: #{elapsed_time}"

puts TimeReceive.today? # Check if today

target_date = Date.parse("2024-05-10")
days_remaining = TimeReceive.days_until(target_date)
puts "Days until #{target_date}: #{days_remaining}"

user_time = Time.parse("2024-05-01 12:00:00") # Replace with user-provided time
remaining_seconds = 3720 # 1 hour, 2 minutes, and 0 seconds

formatted_time = TimeReceive.format_remaining_time(remaining_seconds)
puts formatted_time # Output: "01:02:00"

TimeReceive.timer(user_time) do
  puts "Время истекло!"
end

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
