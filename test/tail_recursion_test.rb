require_relative '../tips_tricks/tail_recursion'
require 'test/unit'

class TailRecursionTest < Test::Unit::TestCase
  def test_factorial
    assert_equal 6, factorial(3), "factorial of 3 should be 6"
    assert_equal 120, factorial(5), "factorial of 5 should be 120"
    assert_equal 720, factorial(6), "factorial of 6 should be 720"
  end

  def test_memo_factorial
    assert_equal 6, memo_factorial(3), "tail factorial of 3 should be 6"
    assert_equal 120, memo_factorial(5), "tail factorial of 5 should be 120"
    assert_equal 720, memo_factorial(6), "tail factorial of 6 should be 720"
  end

  def test_tail_factorial
    assert_equal 6, tail_factorial(3), "tail factorial of 3 should be 6"
    assert_equal 120, tail_factorial(5), "tail factorial of 5 should be 120"
    assert_equal 720, tail_factorial(6), "tail factorial of 6 should be 720"
  end

  def test_sum
    assert_equal 55, sum(10), "sum of 1 to 10 should be 55"
  end

  def test_tail_sum
    assert_equal 55, tail_sum(10), "tail sum of 1 to 10 should be 55"
  end
end
