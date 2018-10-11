# Problem:
# Given two strings: str1 and str2, find their longest common substring
# Example: str1 = abcdef str2 = xbcd66f => bcd
#
# * construct a 2d array(str1.len * str2.len) store the length of common substring at array[i][j]
#       a  b  c  d  e  f
#     0 0  0  0  0  0  0
#   x 0 0  0  0  0  0  0
#   b 0 0  0  0  0  0  0
#   c 0 0  0  0  0  0  0
#   d 0 0  0  0  0  0  0
#   6 0 0  0  0  0  0  0
#   6 0 0  0  0  0  0  0
#   f 0 0  0  0  0  0  0
# NOTE: the 1st row and col has no logical meanning, just for simplicity
# ensure that i - 1, j - 1 always >= 0, prevent out of index exception
#
# * loop through all the rows and cols, if two chars match then update the array
#   array[i][j] = array[i - 1][j - 1] + 1. think the array as a matrix,when match occures
#   the value at array[i][j] is its closest upper left element's value + 1
#       a  b  c  d  e  f
#     0 0  0  0  0  0  0
#   x 0 0  0  0  0  0  0
#   b 0 0  1  0  0  0  0 => match b   found at [2][2] = [1][1] + 1 = 0 + 1 = 1
#   c 0 0  0  2  0  0  0 => match bc  found at [3][3] = [2][2] + 1 = 1 + 1 = 2
#   d 0 0  0  0  3  0  0 => match bcd found at [4][4] = [3][3] + 1 = 2 + 1 = 3
#   6 0 0  0  0  0  0  0
#   6 0 0  0  0  0  0  0
#   f 0 0  0  0  0  0  0

def longest_common_substring(str1, str2)
  len1 = str1.length
  len2 = str2.length
  matrix = Array.new(len1 + 1) { Array.new(len2 + 1, 0) }

  result = {
    :length => 0,
    :last_index => 0
  }

  for i in 1..len1 do
    for j in 1..len2 do
      if str1[i - 1] == str2[j - 1]
        matrix[i][j] = matrix[i - 1][j - 1] + 1

        if matrix[i][j] > result[:length]
          result[:length] = matrix[i][j]
          result[:last_index] = i
        end
      end
    end
  end

  result
end

