require 'benchmark'

def memo_factorial(n, memo = {})
  return n if n <= 1
  memo[n] ||= n * memo_factorial(n - 1, memo)
end

def factorial(n)
  return 1 if n <= 1
  n * factorial(n - 1)
end

N = 8000

Benchmark.bm do |b|
  b.report { memo_factorial N }
  b.report { factorial N }
  # result is kinda similar
end
