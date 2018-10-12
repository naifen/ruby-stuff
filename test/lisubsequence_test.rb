require 'test/unit'
require_relative "../dynamic_programming/longest_increasing_subsequence"

class LCStringTest < Test::Unit::TestCase
  SEQUENCE1 = [10, 22, 9, 33, 21, 50, 41, 60]
  RESULT1 = 5

  SEQUENCE2 = [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]
  RESULT2 = 6

  def test_lis1
    result = longest_increasing_subsequence SEQUENCE1
    assert_equal RESULT1, result, "Expect the result to be #{RESULT1}"
  end

  def test_lis2
    result = longest_increasing_subsequence SEQUENCE2
    assert_equal RESULT2, result, "Expect the result to be #{RESULT2}"
  end
end
