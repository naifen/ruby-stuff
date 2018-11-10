require 'test/unit'
require_relative "../searching-sorting/binary_search"

class BinarySearchTest < Test::Unit::TestCase
  ARRAY = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

  TARGET1 = 10
  RESULT1 = 9

  TARGET2 = 5
  RESULT2 = 4

  TARGET3 = 20
  RESULT3 = -1


  def test_bs1
    result = binary_search ARRAY, TARGET1
    assert_equal RESULT1, result, "Expect the result to be #{RESULT1}"
  end

  def test_bs2
    result = binary_search ARRAY, TARGET2
    assert_equal RESULT2, result, "Expect the result to be #{RESULT2}"
  end

  def test_bs3
    result = binary_search ARRAY, TARGET3
    assert_equal RESULT3, result, "Expect the result to be #{RESULT3}"
  end
end
