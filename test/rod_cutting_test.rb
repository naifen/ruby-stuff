require 'test/unit'
require_relative "../dynamic_programming/rod_cutting"

class RodCuttingTest < Test::Unit::TestCase
  ROD1 = {
    0 => 0,
    1 => 1,
    2 => 5,
    3 => 8,
    4 => 9,
    5 => 10,
    6 => 17,
    7 => 17,
    8 => 20,
    9 => 24,
    10 => 30
  }
  ROD1_MAX_VAL = 30
  ROD1_CUT = [10, 0]

  ROD2 = {
    0 => 0,
    1 => 1,
    2 => 5,
    3 => 8,
    4 => 9,
    5 => 10,
    6 => 17,
    7 => 17,
    8 => 20
  }
  ROD2_MAX_VAL = 22
  ROD2_CUT = [2, 6]

  def test_cut_rod_dp
    assert_equal ROD1_MAX_VAL, cut_rod_dp(ROD1).values.last[:val], "Expect rod1 max val to equal #{ROD1_MAX_VAL}"
    assert_equal ROD1_CUT, cut_rod_dp(ROD1).values.last[:cut], "Expect rod1 cut to equal #{ROD1_CUT}"

    assert_equal ROD2_MAX_VAL, cut_rod_dp(ROD2).values.last[:val], "Expect rod1 max val to equal #{ROD2_MAX_VAL}"
    assert_equal ROD2_CUT, cut_rod_dp(ROD2).values.last[:cut], "Expect rod1 cut to equal #{ROD2_CUT}"
  end
end


