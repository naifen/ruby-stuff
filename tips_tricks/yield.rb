# When use yield, few difference from a regular method call
# i) The block is now no longer a parameter to the method. The block has been
# implicitly passed to the method - NOTE how it's outside the parentheses.
# ii) Yield makes executing the block like a method invocation within the method
# invocation rather than a block that's being explicitly called using Proc#call.
# iii) You have no handle to the block object anymore, yield "magically" invokes
# it without any object references being involved.

# Naive yield usage
def burger
  puts 'top bun'
  yield if block_given?
  puts 'bottom bun'
end

burger do
  puts 'lettuce'
  puts 'tomato'
  puts 'chicken breast'
end
# top bun                                                                                                │
# lettuce                                                                                                │
# tomato                                                                                                 │
# chicken breast                                                                                         │
# bottom bun
# => nil

# yield can also take arguments and later expose |arg1, arg2, ...| to invocation
def print_twice(a, b)
  yield a # ========\
  yield b # =========\
end                 # |
                    # |
print_twice(3, 4) do |n|
  puts n * 10
end
# 30
# 40
# => nil

def calculation(a, b)
  yield(a, b)
end    #  \|==================
                        # |  |
puts calculation(5, 6) { |a, b| a + b } # => 11

# NOTE: however yield can take arguments, it's not a function
# Ruby's Object Oriented rule dosen't apply to yield
# puts method(:yield) # => message: undefined method `yield' for class `Object'

# using yield is slightly fast then Proc#call
require "benchmark"

def calculation_with_explicit_block_passing(a, b, operation)
 operation.call(a, b)
end

def calculation_with_implicit_block_passing(a, b)
 yield(a, b)
end

Benchmark.bm(10) do |report|
 report.report("explicit") do
   addition = lambda { |a, b| a + b }
   100000.times { calculation_with_explicit_block_passing(5, 5, addition) }
 end

 report.report("implicit") do
   100000.times { calculation_with_implicit_block_passing(5, 5) { |a, b| a + b } }
 end
end

# Sample STDOUT:
# Rehearsal ---------------------------------------------
# explicit    0.020000   0.000000   0.020000 (  0.018351)
# implicit    0.010000   0.000000   0.010000 (  0.011923)
# ------------------------------------ total: 0.030000sec

                # user     system      total        real
# explicit    0.020000   0.000000   0.020000 (  0.018469)
# implicit    0.010000   0.000000   0.010000 (  0.011516)

# NOTE: using yield with Class instance, instance variable can be mutated
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def do_with_name
    yield(@name)
  end
end

p =  Person.new 'John Doe'
p.do_with_name { |name| name.reverse! }
puts p.name # => "eoD nhoJ"
