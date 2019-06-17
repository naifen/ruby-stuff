require 'benchmark'
N = 10_000
NF = 30

# NOTE: b/c tailcall_optimization is set to false by default in RubyVM,
# require "pp"
# pp RubyVM::InstructionSequence.compile_option
#
# to use tail recursion in this file, open a REPL and do the followings:
# require "./tail_recur_config.rb"
# => true
# > require "./tail_recursion.rb"
# => true
# and call tail recursion methods
#
################################################################################
# FACTORIAL
################################################################################
# normal factorial, not memory friendly
# factorial(5)
# 5 * factorial(4)
# 5 * (4 * factorial(3))
# 5 * (4 * (3 * factorial(2)))
# 5 * (4 * (3 * (2 * factorial(1))))
# 5 * (4 * (3 * (2 * 1))) => 120
def factorial(n)
  return n if n == 1

  n * factorial(n - 1)
end

# Compare to normal recursive factorial, this one dose not have incomplete method
# calls pushed into stack
# tail_factorial(5, 1)
# tail_factorial(4, 5)
# tail_factorial(3, 20)
# tail_factorial(2, 60)
# tail_factorial(1, 120)
# return 120
def tail_factorial(n, prod = 1)
  return prod if n == 1

  tail_factorial(n - 1, n * prod) # just return a function call
end

def memo_factorial(n, memo = {})
  return n if n <= 1
  memo[n] ||= n * memo_factorial(n - 1, memo) # not a function call tho
end


# factorial N * 10 # => SystemStackError: stack level too deep
# tail_factorial N * 10 # => works

def bench_factorial
  Benchmark.bm do |b|
    b.report { factorial N}
    b.report { memo_factorial N / 10 }
    b.report { tail_factorial N * 10 } # takes order of magnitude larger value
  end
end

################################################################################
# SUM
################################################################################
# normal sum, not memory friendly
def sum(n)
  return 1 if n == 1

  n + sum(n - 1)
end

# tail sum version, pass an additional parameter total, update it in each
# recursive call and return it finally when n reachs 0
# instead of pushing incomplete method calls to stack (eg, normal version)
# call to stack
def tail_sum(n, total = 0)
  return total if n == 0

  tail_sum(n - 1, total + n)
end

def bench_sum
  Benchmark.bm do |b|
    b.report { sum N }
    b.report { tail_sum N * 10 } # takes order of magnitude larger value
  end
end

################################################################################
# Fibonacci
################################################################################
def slow_fib(n)
  n <= 1 ? n : slow_fib(n - 1) + slow_fib(n - 2)
end

def tail_fib(n, a = 0, b = 1)
  return a if n == 0
  return b if n == 1

  tail_fib(n - 1, b, a + b)
end

def bench_fib
  Benchmark.bm do |b|
    b.report { slow_fib NF }
    b.report { tail_fib NF * 100 } # orders of magnitude faster, takes bigger number
  end
end

