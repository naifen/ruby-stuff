require_relative '../command_line/clock_angle_calculator'
require 'test/unit'

class ClockAngleTest < Test::Unit::TestCase
  def test_angle
    assert_equal 47.5,  ClockAngle.new(3, 25).get_angle
    assert_equal 157.5, ClockAngle.new(3, 45).get_angle
    assert_equal 135,   ClockAngle.new(10, 30).get_angle
    assert_equal 125,   ClockAngle.new(6, 10).get_angle
    assert_equal 82.5,  ClockAngle.new(12, 15).get_angle
    assert_equal 105,   ClockAngle.new(9, 30).get_angle
  end
end
