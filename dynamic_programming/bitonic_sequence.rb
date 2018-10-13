require_relative './longest_increasing_subsequence'

# Problem:
# Find the length of the longest Bitonic Sequence in a given sequence of numbers
# a Bitonic sequence is a sequence of numbers which are increasing and then decreasing

# find the longest increasing subsequence and the longest decresaing subsequence
# @param seq [Array<Integer>] a given sequence eg, [2, 8, 10 ... 5, 3]
def longest_bitonic_sequence(seq)
  len = seq.length
  lic = [1] * len # or Array.new(len, 1)
  ldc = [1] * len # or Array.new(len, 1)

  # for i in (1..len - 1)
    # for j in (0..i - 1)
      # if seq[i] > seq[j]
        # lic[i] = max(lic[i], lic[j] + 1)
      # end
    # end
  # end

  lic = longest_increasing_subsequence(seq)

  (0..len - 2).reverse_each do |i|
    ((i - 1)..len - 1).reverse_each do |j|
      if seq[i] > seq[j]
        ldc[i] = [ldc[i], ldc[j] + 1].max
      end
    end
  end

  max_value = 0

  for i in (0..len)
    bitonic_sequence_length = lic[i] + ((ldc[i] || 0) - 1) || 0
    max_value = [max_value, bitonic_sequence_length].max
  end

  max_value
end
# TODO add test

max_value = longest_bitonic_sequence([1, 4, 3, 7, 2, 1, 8, 11, 13, 0])
puts max_value
