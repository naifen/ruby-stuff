# Calculate angle between hour and minute hand at a given time.
class CACalculator
  TOTAL_ANGLE = 360.0
  HOURS_PER_CIRCLE = 12.0
  MINUTES_PER_CIRCLE = 60.0

  def initialize(hour, minute)
    @hour = hour < 12 ? hour : hour - 12
    @minute = minute
  end

  def calculate_angle
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

ca1 = CACalculator.new(3, 25) # 47.5
puts ca1.calculate_angle

ca2 = CACalculator.new(3, 45) # 157.5
puts ca2.calculate_angle

ca3 = CACalculator.new(10, 30) # 135
puts ca3.calculate_angle

ca4 = CACalculator.new(6, 10) # 125
puts ca4.calculate_angle

ca5 = CACalculator.new(12, 15) # 82.5
puts ca5.calculate_angle
