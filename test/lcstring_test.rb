require 'test/unit'
require_relative "../dynamic_programming/longest_common_substring"

class LCStringTest < Test::Unit::TestCase
  STR1A = "OldSite:GeeksforGeeks.org"
  STR1B = "NewSite:GeeksQuiz.com"
  RESULT1 = "Site:Geeks"

  STR2A = "abcdef"
  STR2B = "zcdemf"
  RESULT2 = "cde"

  STR3A = "xbz"
  STR3B = "zxbzmf"
  RESULT3 = "xbz"

  def test_lcs1
    result = longest_common_substring STR1A, STR1B
    lcs = STR1A.slice((result[:last_index] - result[:length]), result[:length])
    assert_equal RESULT1, lcs, "Expect the result to be #{RESULT1}"
  end

  def test_lcs2
    result = longest_common_substring STR2A, STR2B
    lcs = STR2A.slice((result[:last_index] - result[:length]), result[:length])
    assert_equal RESULT2, lcs, "Expect the result to be #{RESULT2}"
  end

  def test_lcs3
    result = longest_common_substring STR3A, STR3B
    lcs = STR3A.slice((result[:last_index] - result[:length]), result[:length])
    assert_equal RESULT3, lcs, "Expect the result to be #{RESULT3}"
  end
end
