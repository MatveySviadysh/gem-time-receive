# frozen_string_literal: true

RSpec.describe TimeReceive do
  it "has a version number" do
    expect(TimeReceive::VERSION).not_to be nil
  end
end

require 'rspec'
require 'time_receive'

RSpec.describe TimeReceive::TimeFormatter do
  describe '#initialize' do
    # it 'raises an error for a non-string format_string' do
    #   expect { TimeReceive::TimeFormatter.new(123) }.to raise_error(ArgumentError)
    # end

    it 'accepts a string format_string' do
      formatter = TimeReceive::TimeFormatter.new("%Y-%m-%d")
      expect(formatter.instance_variable_get(:@format_string)).to eq("%Y-%m-%d")
    end
  end

  describe '#format' do
    let(:formatter) { TimeReceive::TimeFormatter.new("%Y-%m-%d") }

    # Option 1: Create an instance of the error
    it 'raises an error for a non-Time object' do
      expect { formatter.format("not a time") }.to raise_error(TimeReceive::TimeReceiveError)
    end

    # Option 2: Catch any error raised (assuming all errors are subclasses of StandardError)
    # it 'raises an error for a non-Time object' do
    #   expect { formatter.format("not a time") }.to raise_error(StandardError)
    # end

    it 'formats a Time object according to the format string' do
      time = Time.parse("2024-04-24 12:00:00 UTC")
      formatted_time = formatter.format(time)
      expect(formatted_time).to eq("2024-04-24")
    end
  end
end

RSpec.describe TimeReceive, type: :module do
  describe '.now' do
    it 'returns the current time formatted with the default format' do
      allow(Time).to receive(:now).and_return(Time.parse("2024-04-24 12:00:00 UTC"))
      formatted_time = TimeReceive.now
      expect(formatted_time).to match(/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/) # Match a typical time format
    end

    it 'returns the current time formatted with a custom format' do
      allow(Time).to receive(:now).and_return(Time.parse("2024-04-24 12:00:00 UTC"))
      formatted_time = TimeReceive.now("%H:%M")
      expect(formatted_time).to eq("12:00")
    end
  end

  describe '.parse_time' do
    it 'raises an error for an invalid time string' do
      expect { TimeReceive.parse_time("not a time", "%Y-%m-%d") }.to raise_error(TimeReceive::TimeReceiveError) # Use the correct constant name
    end

    it 'parses a valid time string according to the format string' do
      parsed_time = TimeReceive.parse_time("2024-04-24", "%Y-%m-%d")
      expect(parsed_time).to be_a(Time)
      expect(parsed_time.year).to eq(2024)
      expect(parsed_time.month).to eq(4)
      expect(parsed_time.day).to eq(24)
    end
  end
end
