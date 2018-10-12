# Problem:
# Find the length of the longest Bitonic Sequence in a given sequence of numbers
# a Bitonic sequence is a sequence of numbers which are increasing and then decreasing

# find the longest increasing subsequence and the longest decresaing subsequence
# @param seq [Array<Integer>] a given sequence eg, [2, 8, 10 ... 5, 3]
def longest_bitonic_sequence(seq)
  input_length = seq.length
  increasing_sequence = Array.new(input_length, 1)
  decreasing_sequence = Array.new(input_length, 1)

  for i in (1..input_length - 1)
    for j in (0..i - 1)
      if seq[i] > seq[j]
        increasing_sequence[i] = max(increasing_sequence[i], increasing_sequence[j] + 1)
      end
    end
  end

  (0..input_length - 2).reverse_each do |i|
    ((i - 1)..input_length - 1).reverse_each do |j|
      if seq[i] > seq[j]
        decreasing_sequence[i] = max(decreasing_sequence[i], decreasing_sequence[j] + 1)
      end
    end
  end

  max_value = 0

  for i in (0..input_length)
    bitonic_sequence_length = increasing_sequence[i] + decreasing_sequence[i] - 1
    max_value = max(max_value, bitonic_sequence_length)
  end

  max_value
end
# TODO add test
