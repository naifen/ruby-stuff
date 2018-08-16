# normal fibonacci, memory costly
def factorial(n)
  return n if n == 1

  n * factorial(n - 1)
end

puts factorial 10

def tailFact(n, prod)
  return prod if n == 1

  tailFact(n - 1, n * prod)
end

puts tailFact(10, 1)
