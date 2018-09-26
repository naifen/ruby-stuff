# Given a rod of length N inches and an array of prices that contains prices of
# all pieces of size smaller than n. Determine the maximum value obtainable by
# cutting up the rod and selling the pieces. Use following arrays as sample data
# rod in length 1 has value 1, rod in length 2 has value 5, etc...

# 1, Dynamic Programming Version:
# To find out max value of current l,ength, compare all possible cut combinations
# with max value and store the max possible value of each length in result
# For example rod[3]:
# 1, compare rod[1] + result[2] with max
# 2, compare rod[2] + result[1] with max
# 3, compare rod[3] + result[0] with max
#
# NO NEED to concern the max value of length 2 and 1
# because they can be found in result[1] and result[2]
#
# Diagram illustrates cutting rod of length 3:
#
#                                 cut(3)
#                                    |
#                          /---------|-----------\
#                         /          |            \
#        rod[1] + result[2]  rod[2] + result[1]   rod[3] + result[0]
#                    |                  |
#                    |       rod[1] + result[0]
#                    |
#                   / \
#  rod(1) + result(1)  rod(2) + result(0)
#
#  eg, for cut(5) calculate
#  1, rod[1] + result[4]   2, rod[2] + result[3]   3, rod[3] + result[2]
#  4, rod[4] + result[1]   5, rod[5] + result[0]

# @param rod [Hash{Int => Int}] a hash representing value of each cut of a rod
# eg, { 1 => 3, 2 => 5, 3 => 8 }
def cut_rod_dp(rod)
  result = {
    0 => { :max_val => rod[0], :cut => [0] },
    1 => { :max_val => rod[1], :cut => [rod[1], 0] },
  } # store the maximum value and its associated cuts

  rod.slice(*(2..rod.keys.last)).each do |k, v|
    max = -1 # assume cut value won't be negative

    (1..k).each do |x|
      value = rod[x] + result[k - x][:max_val]

      if value > max
        max = value
        result[k] = { :max_val => max, :cut => [x, k - x] }
      end
    end
  end

  return result
end

