# Problem:
# Find the length of the longest Bitonic Sequence in a given sequence of numbers
# a Bitonic sequence is a sequence of numbers which are increasing and then decreasing

# find the longest increasing subsequence and the longest decresaing subsequence
# @param sequence [Array<Integer>] a given sequence eg, [2, 8, 10 ... 5, 3]
def longest_bitonic_sequence(sequence)
  len = sequence.length

  # first find the longes increasing subsequence for each index
  lis = [1] * len # or Array.new(len, 1)

  for i in (1..(len - 1))
    for j in (0..(i - 1))
      if sequence[i] > sequence[j] && lis[i] < lis[j] + 1
        lis[i] = lis[j] + 1
      end
    end
  end

  # second find the longes decreasing subsequence for each index
  lds = [1] * len # or Array.new(len, 1)

  (len - 2).downto(0) do |i|
    (len - 1).downto(i - 1) do |j|
      if sequence[i] > sequence[j] && lds[i] < lds[j] + 1
        lds[i] = lds[j] + 1
      end
    end
  end

  result = lis[0] + lds[0] - 1

  # calculate longest bitonic seq at each index i, and compare with result
  # subtract 1 because the number itself is overlapped
  for i in (1..len - 1)
    result = [(lis[i] + lds[i] - 1), result].max
  end

  result
end
