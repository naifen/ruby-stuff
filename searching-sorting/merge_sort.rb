# Time complexity of Merge Sort is O(nLogn) in all 3 cases (worst, average and best)
# as merge sort always divides the array in two halves and take linear time to merge two halves.

def merge_sort(array)
  return array if array.length < 2

  mid = array.length / 2
  left = merge_sort array.slice(0, mid)
  right = merge_sort array.slice(mid, array.length - mid)

  result = []
  i = 0
  j = 0

  while i < left.length && j < right.length
    # push elements into result array, from smallest to largest order
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  # check if any element was left and add to result
  while i < left.length
    result << left[i]
    i += 1
  end

  while j < right.length
    result << right[j]
    j += 1
  end

  return result
end

