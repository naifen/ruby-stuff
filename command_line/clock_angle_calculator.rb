#!/usr/bin/env ruby

require 'thor'

# Calculate angle between hour and minute hand at a given time.
class ClockAngle
  TOTAL_ANGLE = 360.0
  HOURS_PER_CIRCLE = 12.0
  MINUTES_PER_CIRCLE = 60.0

  def initialize(hour, minute)
    @hour = hour < 12 ? hour : hour - 12
    @minute = minute
  end

  def get_angle
    if angle_between_minute_hand_and_noon_clockwise > angle_between_hour_hand_and_noon_clockwise
      angle_between_minute_hand_and_noon_clockwise - angle_between_hour_hand_and_noon_clockwise
    else
      angle_between_hour_hand_and_noon_clockwise - angle_between_minute_hand_and_noon_clockwise
    end
  end

  private

  def angle_per_minute
    TOTAL_ANGLE / MINUTES_PER_CIRCLE
  end

  def angle_per_hour
    TOTAL_ANGLE / HOURS_PER_CIRCLE
  end

  def angle_between_minute_hand_and_noon_clockwise
    @minute * angle_per_minute
  end

  def angle_between_hour_hand_and_noon_clockwise
    base_angle = @hour * angle_per_hour
    # calculates hour offsets created by minutes
    base_angle += @minute / MINUTES_PER_CIRCLE * angle_per_hour
    base_angle
  end
end

class ClockAngleCalculator < Thor
  desc "angle_between hour minute", "Calculate angle between hour(1st arg) and minute(2nd arg)"
  def angle_between(hour, minute)
    result = ClockAngle.new(hour.to_i, minute.to_i).get_angle
    puts "Angle between hour and clock hands at #{hour}:#{minute} is: #{result}"
  end
end

ClockAngleCalculator.start(ARGV)

# usage: chmod +x clock_angle_calculator.rb
# ./clock_angle_calculator.rb angle_between 9 25
