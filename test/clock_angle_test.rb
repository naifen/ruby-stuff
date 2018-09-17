require_relative '../clock_angle_calculator'
require 'test/unit'

class ClockAngleTest < Test::Unit::TestCase
  def test_angle
    assert_equal 47.5, ClockAngleCalculator.new(3, 25).calculate_angle
    assert_equal 157.5, ClockAngleCalculator.new(3, 45).calculate_angle
    assert_equal 135, ClockAngleCalculator.new(10, 30).calculate_angle
    assert_equal 125, ClockAngleCalculator.new(6, 10).calculate_angle
    assert_equal 82.5, ClockAngleCalculator.new(12, 15).calculate_angle
    assert_equal 105, ClockAngleCalculator.new(9, 30).calculate_angle
  end
end
