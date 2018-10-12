require 'test/unit'
require_relative "../dynamic_programming/longest_common_subsequence"

class LCStringTest < Test::Unit::TestCase
  STR1A = "ABCDGHLQR"
  STR1B = "AEDPHR"
  RESULT1 = "ADHR"

  STR2A = "AGGTAB"
  STR2B = "GXTXAYB"
  RESULT2 = "GTAB"

  def test_lcs1
    result = longest_common_subsequence STR1A, STR1B
    # lcs = STR1A.slice((result[:last_index] - result[:length]), result[:length])
    assert_equal RESULT1, result, "Expect the result to be #{RESULT1}"
  end

  def test_lcs2
    result = longest_common_subsequence STR2A, STR2B
    # lcs = STR2A.slice((result[:last_index] - result[:length]), result[:length])
    assert_equal RESULT2, result, "Expect the result to be #{RESULT2}"
  end
end
