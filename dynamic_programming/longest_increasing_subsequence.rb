# Problem:
# Find a subsequence in given array in which the subsequence's elements are in
# sorted order, lowest to highest, and in which the subsequence is as long as possible.

# The idea is to create a temp array with the same size of given sequence
# give it default value of 1s, which would be [1, 1, 1, ... 1]
# then compare each element in the given sequence with all elements to its left
# (n^2 for loop) find the length of the longest increasing subsequence for that
# element and update the element of corresponding index in the temp array
#
# For example:
#  j     i      NOTE: i is current element's index, j is all indexes to i's left
# [2, 0, 1, 3, -1] the given sequence
#
# [1, 1, 1, 1, 1]  the temp sequence
#
# iteration#1 1 < 2 do nothing
# iteration#2 i < 0 => 1temp[i] = temp[j + 1]
# NOTE: meaning element at i's lis length is at least 1 more than element at j's

# @param sequence [Array<Integer>] a given sequence eg, [2, 8, 10 ... 5, 3]
def longest_increasing_subsequence(sequence)
  len = sequence.length

  # construct a temp array to store lenght of LIS at each index(default len: 1)
  temp = [1] * len # or Array.new(len, 1)

  # Compute optimized LIS values in a bottom up manner
  for i in (1..(len - 1))
    for j in (0..(i - 1))
      if sequence[i] > sequence[j] && temp[i] < temp[j] + 1
        temp[i] = temp[j] + 1
      end
    end
  end

  # maximum = 0

  # for i in (0..(len - 1))
    # maximum = [maximum , temp[i]].max
  # end

  return temp.max
end
# TODO: also show the actual longest increasing subsequence

arr = [10, 22, 9, 33, 21, 50, 41, 60]
puts "Length of LIS is", longest_increasing_subsequence(arr)

arr2 = [10, 22, 9, 33, 21, 50, 41, 60, 73, 8, 91]
puts "Length of LIS is", longest_increasing_subsequence(arr2)
