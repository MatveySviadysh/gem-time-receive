# frozen_string_literal: true

RSpec.describe TimeReceive do
  it "has a version number" do
    expect(TimeReceive::VERSION).not_to be nil
  end
end

require "rspec"
require "time_receive"

RSpec.describe TimeReceive::TimeFormatter do
  describe "#initialize" do
    it "accepts a string format_string" do
      formatter = TimeReceive::TimeFormatter.new("%Y-%m-%d")
      expect(formatter.instance_variable_get(:@format_string)).to eq("%Y-%m-%d")
    end
  end

  describe "#format" do
    let(:formatter) { TimeReceive::TimeFormatter.new("%Y-%m-%d") }

    it "raises an error for a non-Time object" do
      expect { formatter.format("not a time") }.to raise_error(TimeReceive::TimeReceiveError)
    end

    it "formats a Time object according to the format string" do
      time = Time.parse("2024-04-24 12:00:00 UTC")
      formatted_time = formatter.format(time)
      expect(formatted_time).to eq("2024-04-24")
    end
  end
end

RSpec.describe TimeReceive, type: :module do
  describe ".now" do
    it "returns the current time formatted with the default format" do
      allow(Time).to receive(:now).and_return(Time.parse("2024-04-24 12:00:00 UTC"))
      formatted_time = TimeReceive.now
      expect(formatted_time).to match(/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/)
    end

    it "returns the current time formatted with a custom format" do
      allow(Time).to receive(:now).and_return(Time.parse("2024-04-24 12:00:00 UTC"))
      formatted_time = TimeReceive.now("%H:%M")
      expect(formatted_time).to eq("12:00")
    end
  end

  describe ".parse_time" do
    it "raises an error for an invalid time string" do
      expect { TimeReceive.parse_time("not a time", "%Y-%m-%d") }.to raise_error(TimeReceive::TimeReceiveError)
    end

    it "parses a valid time string according to the format string" do
      parsed_time = TimeReceive.parse_time("2024-04-24", "%Y-%m-%d")
      expect(parsed_time).to be_a(Time)
      expect(parsed_time.year).to eq(2024)
      expect(parsed_time.month).to eq(4)
      expect(parsed_time.day).to eq(24)
    end
  end

  describe "#timer" do
    context "when a valid user_time is provided" do
      it "executes the provided block after the timer finishes" do
        start_time = Time.now + 2 # Set user_time 2 seconds ahead

        block_executed = false
        TimeReceive.timer(start_time) { block_executed = true }

        expect(block_executed).to be true
      end
    end

    context "when an invalid user_time is provided" do
      it "raises an ArgumentError" do
        start_time = "2024-04-28 12:00:00"

        expect { TimeReceive.timer(start_time) }.to raise_error(ArgumentError, /Invalid user_time/)
      end
    end
  end

  describe ".format_remaining_time" do
    it "formats remaining seconds into hours, minutes, and seconds" do
      remaining_seconds = 3660 # 1 hour, 1 minute, 0 seconds

      formatted_time = TimeReceive.format_remaining_time(remaining_seconds)
      expect(formatted_time).to eq("01:01:00")
    end
  end

  describe ".days_until" do
    it "raises an error for a non-Date target_date" do
      expect { TimeReceive.days_until("not a date") }.to raise_error(ArgumentError)
    end

    it "calculates the number of days until a target date" do
      target_date = Date.parse("2024-05-10")

      days_remaining = TimeReceive.days_until(target_date)
      expect(days_remaining).to be >= 0
    end
  end

  describe "#today?" do
    context "when the current date matches the current time" do
      it "returns true" do
        expect(TimeReceive.today?).to be true
      end
    end

    context "when the current date does not match the current time" do
      it "returns false" do
        allow(Date).to receive(:today).and_return(Date.today + 1)

        expect(TimeReceive.today?).to be false
      end
    end
  end

  describe "#calculate_elapsed_time" do
    context "when valid start_time and end_time are provided" do
      it "calculates the elapsed time correctly" do
        start_time = Time.parse("2024-04-28 12:00:00")
        end_time = Time.parse("2024-04-28 14:30:00")

        expect(TimeReceive.calculate_elapsed_time(start_time, end_time)).to eq("2 hours and 30 minutes")
      end
    end

    context "when invalid start_time or end_time is provided" do
      it "raises an ArgumentError" do
        start_time = "2024-04-28 12:00:00"
        end_time = "2024-04-28 14:30:00"

        expect do
          TimeReceive.calculate_elapsed_time(start_time, end_time)
        end.to raise_error(ArgumentError, /Invalid start_time/)
      end
    end
  end

  describe "#add_time_period" do
    context "when adding days" do
      it "adds the specified number of days to the given time" do
        start_time = Time.parse("2024-04-28 12:00:00")
        expected_time = Time.parse("2024-04-29 12:00:00")

        new_time = TimeReceive.add_time_period(start_time, :days)
        expect(new_time).to eq(expected_time)
      end
    end

    context "when an unsupported period is provided" do
      it "raises an ArgumentError" do
        start_time = Time.now

        expect { TimeReceive.add_time_period(start_time, :seconds) }.to raise_error(ArgumentError, /Unsupported period/)
      end
    end

    context "when an invalid time is provided" do
      it "raises an ArgumentError" do
        start_time = "2024-04-28 12:00:00"

        expect { TimeReceive.add_time_period(start_time, :hours) }.to raise_error(ArgumentError, /Invalid time/)
      end
    end
  end
end
