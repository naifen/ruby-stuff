require 'test/unit'
require_relative "../searching-sorting/merge_sort"

class MergeSortTest < Test::Unit::TestCase
  ARRAY1 = [64, 34, 25, 12, 22, 11, 90]
  RESULT1 = [11, 12, 22, 25, 34, 64, 90]

  ARRAY2 = [31, 11, 22, 10, 4, 5, 2, 1]
  RESULT2 = [1, 2, 4, 5, 10, 11, 22, 31]

  def test_ms1
    result = merge_sort ARRAY1
    assert_equal RESULT1, result, "Expect the result to be #{RESULT1}"
  end

  def test_ms2
    result = merge_sort ARRAY2
    assert_equal RESULT2, result, "Expect the result to be #{RESULT2}"
  end
end
