require 'benchmark'

def factorial(n, memo = {})
  return n if n <= 1
  memo[n] = n * factorial(n - 1, memo)
end

def factorial2(n)
  return 1 if n <= 1
  n * factorial(n - 1)
end

n = 5000

Benchmark.bm do |b|
  b.report { factorial n }
  b.report { factorial2 n }
end
