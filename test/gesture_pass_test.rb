require_relative '../command_line/gesture_passcode_generator'
require 'test/unit'

class GesturePassTest < Test::Unit::TestCase
  def test_pass
    assert_equal 6,  GesturePasscode.new(2, 6).get_passcode_from_hsh.length
  end
end

