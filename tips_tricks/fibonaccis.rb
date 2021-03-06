require 'benchmark'

# one liner fib but slow due to repeated calculation
def slow_fib(n)
  n <= 1 ? n : slow_fib(n - 1) + slow_fib(n - 2)
end

# memoization repeated calculation
def memo_fib(n, memo = {})
  return n if n <= 1
  memo[n] ||= memo_fib(n - 1, memo) + memo_fib(n - 2, memo) # two memo_fib call will repeat calculats w/o memo
end
################################################################################
# Digram of Ruby fibonacci w/ memoization, eliminates repeated calculation     #
################################################################################
#
# fib(5, {})                    VI|- NOTE memo[3] is already set so return 2 without perform any calculation
#   |-memo[5] ||= fib(4, memo) + fib(3, memo)
#                 |I
#                 |-memo[4] = fib(3, memo) + fib(2, memo) => 2 + 1 => 3 NOTE: memo is now { 2 => 1, 3 => 2, 4 => 3 }
#                             |II eval to 2   |V
#                             |               |- fib(1, memo) + fib(0, memo) => 1 + 0 => 1
#                             |
#                             |- NOTE: memo is { 2 => 1, 3 => 2} AFTER IV
#                             |                             IV|- n == 1 return 1
#                             |-memo[3] = fib(2, memo)   +  fib(1, memo) => NOTE: memo is now { 3 => 2 }
#                                      III|-memo[2] = 1 + 0 => NOTE: memo is now { 2 => 1 }
#
# NOTE: to inspect memoization add "puts memo" right above memo[n] ||= line
# this is the print result for fib(10)
# {}
# {}
# {}
# {}
# {}
# {}
# {}
# {}
# {}
# {2=>1, 3=>2}
# {2=>1, 3=>2, 4=>3}
# {2=>1, 3=>2, 4=>3, 5=>5}
# {2=>1, 3=>2, 4=>3, 5=>5, 6=>8}
# {2=>1, 3=>2, 4=>3, 5=>5, 6=>8, 7=>13}
# {2=>1, 3=>2, 4=>3, 5=>5, 6=>8, 7=>13, 8=>21}
# {2=>1, 3=>2, 4=>3, 5=>5, 6=>8, 7=>13, 8=>21, 9=>34}


################################################################################
# Fibonacci hacks:                                                             #
################################################################################
# NO.1 Hash block initializer hack, see following ri doc example
# While this creates a new default object each time
# h = Hash.new { |hash, key| hash[key] = "Go Fish: #{key}" }
# h["c"]           #=> "Go Fish: c"
# h["c"].upcase!   #=> "GO FISH: C"
# h["d"]           #=> "Go Fish: d"
# h.keys           #=> ["c", "d"]
#
# NOTE: Because of the nature of hash, memoization is enabled by default
# So this is so damn fast, call hash_fib[1000] is like instant
hash_fib_tn = Hash.new{ |fib, n| fib[n] = n < 2 ? n : fib[n - 1] + fib[n - 2] }
# merge! version, replace ternary "n < 2 ? n" part with default values
hash_fib_mg = Hash.new { |fib, n| fib[n] = fib[n - 1] + fib[n - 2] }.merge!(0 => 0, 1 => 1)

# NO.2 Lambda fib, envoke with f[n], kinda slow even f[50] takes forever
f = ->(x){ x < 2 ? x : f[x-1] + f[x-2] }

# NO.3 This is super hacky and prints one fib number per line w/ "puts ff[n]"
ff = ->(n, i = 0, j = 1){ (1..n).map{ i = j + j = i } }
# Explain:
# starting point i = 0, j = 1
# I: i = j + j = i => i = 1, j = 0
# NOTE: since = precedes + so it 1st swap i,j like i, j = j, i
# then add i j and assign to i so i is 1, j is 0
# II: i = j + j = i => i = 1, j = 1
# III: i = j + j = i => i = 2, j = 1
# III: i = j + j = i => i = 3, j = 2
# III: i = j + j = i => i = 5, j = 3
# ...

# NO.4 Tail recurssion version, less stack, save memory, handle bigger number
# See tail_recursion.rb file for benchmark
def tail_fib(n, a = 0, b = 1)
  return a if n == 0
  return b if n == 1

  tail_fib(n - 1, b, a + b)
end

################################################################################
# Benchmarks                                                                   #
################################################################################
N = 30

Benchmark.bm do |b|
  b.report { slow_fib N } # slow
  b.report { memo_fib N } # fast
end

# naive and costly fib implementations
def fib_naive(n)
  return 'cannot be negative' if n < 0
  return 1 if n <= 2
  a, b = 0, 1

  while a < n
    puts a
    a, b = b, a + b
  end
end

def recr_fib(a = 0, b = 1, n)
  return if n <= 0 || a > n

  recr_fib(b, a + b, n)
end
