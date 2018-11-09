require 'test/unit'
require_relative "../dynamic_programming/bitonic_sequence"

class LBitonicSequenceTest < Test::Unit::TestCase
  SEQUENCE1 = [0 , 8 , 4, 12, 2, 10 , 6 , 14 , 1 , 9 , 5 , 13, 3, 11 , 7 , 15]
  RESULT1 = 7

  SEQUENCE2 = [1, 11, 2, 10, 4, 5, 2, 1]
  RESULT2 = 6

  def test_lbs1
    result = longest_bitonic_sequence SEQUENCE1
    assert_equal RESULT1, result, "Expect the result to be #{RESULT1}"
  end

  def test_lbs2
    result = longest_bitonic_sequence SEQUENCE2
    assert_equal RESULT2, result, "Expect the result to be #{RESULT2}"
  end
end
