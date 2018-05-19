# ruby ampersand(&) explaination (as of ruby 2.5.1)
# see https://www.reddit.com/r/ruby/comments/29tgdk/question_about_lambdasprocs_and_the_ampersand/ciqlve6/
# & turns a proc object into a "block argument"
# it always call to_proc on its operand(symbol, lambda implement to_proc differently)

# I. use it with lambda/proc makes no difference(a lambda/proc is a proc)
lp = lambda { |x| x * x } # newer syntax: -> { |x| x * x }
lp.to_proc == lp # => true
# However lambda is more strict with arguments
lp.call # => ArgumentError: wrong number of arguments (given 0, expected 1)
lp.call 1, 2 # => ArgumentError: wrong number of arguments (given 2, expected 1)
# proc works just fine, given proc = Proc.new { |x| x * x }
proc.call # => returns nil
proc.call 1, 2 => # returns 1

# Proc lambda difference
# Lambdas are defined with -> {} and procs with Proc.new {}.
# Procs return from the current method, while lambdas return from the lambda itself.
# Procs don’t care about the correct number of arguments, while lambdas will raise an exception.
# many was to call a lambda
# lambda = -> { puts "Lambda called" }
# lambda.call
# lambda.()
# lambda[]
# lambda.===

# II. use it with other data type, eg Symbol also call .to_proc on it
# Symbols implement to_proc to turn themselves into procs in a convenient way
:foo.to_proc => lambda { |x| x.foo }

# some equivalent ways to use proc/block, given following method
def block_method(&block)
  block.class
end

block_method do |x| # they all return Proc
  x.foo
end
# same as
foo_proc = :foo.to_proc
block_method &foo_proc # NOTE: & is needed in block_method call
# same as
block_method &:foo # NOTE: & is needed in block_method call

# when :bar is a symbol of function bar
def bar
  "bar"
end
:bar.to_proc.call(self) # => "bar"

# Combine proc/lambda with Enumerable
# MAP
["a", "b", "c"].map(&:upcase)
#     &:upcase    &:upcase    &:upcase
#     |           |           |
# [  "a".upcase, "b".upcase, "c".upcase]
#
# so  map(&:upcase)  is just like=> map { |e| :upcase.to_proc.call e }
# or a more familiar form=> map { |e| e.upcase }
#
# more examples
intos = ->(int) { int.to_s }
[1, 2, 3].map(&intos) # => ["1", "2", "3"]
# same as [1, 2, 3].map { |x| intos.call x }

["a", "b", "c"].map(&my_proc)
#        &my_proc      &my_proc      &my_proc
#          \             \             \
# [my_proc["a"], my_proc["b"], my_proc["c"]]

# INJECT
["a", "b", "c"].inject(:concat) # NOTE: no & before :concat
#     :concat    :concat
#       \|/        \|/
#  "a".concat "b".concat "c"
#
# inject takes two arguments, above code can be write as following:
fc = ->(a, b) { a + b }
["a", "b", "c"].inject(&fc) # => "abc"

# some more good examples from ridoc
# Sum some numbers
(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
(5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
(5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
    memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"
