require 'test/unit'
require_relative "../dynamic_programming/longest_decreasing_subsequence"

class LDSubequenceTest < Test::Unit::TestCase
  SEQUENCE1 = [1, 4, 3, 7, 2, 1, 8, 11, 13, 0]
  RESULT1 = 5
  SEQUENCE2 = [15, 27, 14, 38, 63, 55, 46, 65, 85]
  RESULT2 = 3
  SEQUENCE3 = [50, 3, 10, 7, 40, 80, 2]
  RESULT3 = 4

  def test_lds1
    result = longest_decreasing_subsequence SEQUENCE1
    assert_equal RESULT1, result, "Expect the result to be #{RESULT1}"
  end

  def test_lds2
    result = longest_decreasing_subsequence SEQUENCE2
    assert_equal RESULT2, result, "Expect the result to be #{RESULT2}"
  end

  def test_lds3
    result = longest_decreasing_subsequence SEQUENCE3
    assert_equal RESULT3, result, "Expect the result to be #{RESULT3}"
  end

end
