require 'test/unit'
require_relative "../dynamic_programming/longest_common_substring"

class LCStringTest < Test::Unit::TestCase
  STR1 = "OldSite:GeeksforGeeks.org"
  STR2 = "NewSite:GeeksQuiz.com"
  RESULT = "Site:Geeks"

  def test_lcs
    result = longest_common_substring STR1, STR2
    lcs = STR1.slice((result[:last_index] - result[:length]), result[:length])
    assert_equal RESULT, lcs, "Expect the result to be #{RESULT}"
  end
end


