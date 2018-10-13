# Problem:
# Find a subsequence in given array in which the subsequence's elements are in
# sorted order, highest to lowest, and in which the subsequence is as long as possible.
#
# Similar to longest_increasing_subsequence, but from right to left
#
# @param sequence [Array<Integer>] a given sequence eg, [9, 8, 10 ... 5, 3]
def longest_decreasing_subsequence(sequence)
  len = sequence.length

  # construct a temp array to store lenght of LDS at each index(default len: 1)
  temp = [1] * len # or Array.new(len, 1)

  (len - 2).downto(0) do |i|
    (len - 1).downto(i - 1) do |j|
      if sequence[i] > sequence[j] && temp[i] < temp[j] + 1
        temp[i] = temp[j] + 1
      end
    end
  end

  return temp.max
end
# TODO: also show the actual longest decreasing subsequence

