# O(LogN)

# @param array [Array<Integer>]
# @param target [Interger] the target to find in array
# returns index of target in array if present, else -1
def binary_search(array, target, from = 0, to = array.length - 1)
  return -1 if array.length < 1

  while from <= to
    mid = from + (to - from) / 2 # use add from as an offset to calculate mid

    if array[mid] == target
      return mid
    elsif array[mid] < target
      from = mid + 1 # find in right part
    else
      to = mid - 1 # find in left part
    end
  end

  # not found in the array
  return -1
end

# def binary_search1(array, target, from = 0, to = array.length - 1)
  # return -1 if array.length < 1
  # # return -1 if array.length < 1

  # mid = from + (to - from) / 2

  # if array[mid] == target
    # return mid
  # elsif array[mid] > target
    # return binary_search1 array, target, from, mid - 1
  # else
    # return binary_search1 array, target, mid + 1, to
  # end
# end

ary = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
puts binary_search(ary, 10)
puts binary_search(ary, 20)
