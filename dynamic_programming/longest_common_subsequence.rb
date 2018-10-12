# Problem:
# Given two sequences, print the longest subsequence present in both of them.
#
# Examples:
# LCS for input Sequences “ABCDGH” and “AEDFHR” is “ADH” of length 3.
# LCS for input Sequences “AGGTAB” and “GXTXAYB” is “GTAB” of length 4.
# sebsequence vs substring: substring has to be adjacent sequence

# @param str1 [String] str2 [String] given strings
def longest_common_subsequence(str1, str2)
  len1 = str1.length
  len2 = str2.length
  matrix = Array.new(len1 + 1) { Array.new(len2 + 1, 0) }

  for i in 1..len1 do
    for j in 1..len2 do
      if str1[i - 1] == str2[j - 1]
        matrix[i][j] = matrix[i - 1][j - 1] + 1
      else
        matrix[i][j] = [matrix[i - 1][j], matrix[i][j - 1]].max
      end
    end
  end

  # puts matrix.map { |x| x.join(' ') } # ruby print 2d Array

  # Demonstrate the direction of the index search
  # 0 0 0 0 0 0 0 0
  # 0 0 0 0 0 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 1 1 1 1 1
  # 0 1 1 2 2 2 2 2
  #       <--
  # 0 1 1 2 2 3 3 3
  #           <--
  # 0 1 1 2 2 3 3 4
  #               <-
  index = matrix[len1][len2] - 1
  lcseq = []
  # Start from the right-most-bottom-most corner and
  # one by one store characters in lcseq[]
  while len1 > 0 && len2 > 0
    # If current character in str1 and str2 are same, then
    # current character is part of LCS
    if str1[len1 - 1] == str2[len2 - 1]
      lcseq[index] = str1[len1 - 1]
      len1  -= 1
      len2  -= 1
      index -= 1
    # If not same, then find the larger of two and
    # go in the direction of larger value, move right if equal
    elsif matrix[len1 - 1][len2] > matrix[len1][len2 - 1]
      len1 -= 1
    else
      len2 -= 1
    end
  end

  lcseq.join('')
end
