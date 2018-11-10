# Best Case: The best case occurs when the partition process always picks the
# middle element as pivot. Following is recurrence for best case is O(nLogn)
# Same for Average Case
# Worst Case is O(n^2)

# takes last element as pivot, places the pivot element at its correct position
# in sorted array, and places all smaller than pivot to left of pivot and all
# greater elements to right of pivot
def partition(arr, low, high)
  pivot = arr[high]
  i = (low - 1) # ensure swap from left most element

  for j in (low..(high - 1))
    if arr[j] <= pivot
      i = i + 1
      arr[i], arr[j] = arr[j], arr[i]
    end
  end

  arr[i + 1], arr[high] = arr[high], arr[i + 1]

  return i + 1
end

def quick_sort(arr, low = 0, high = arr.length - 1)
  if low < high
    # pi is partitioning index, arr[p] is now at right place
    pi = partition(arr, low, high)

    quick_sort(arr, low, pi - 1)
    quick_sort(arr, pi + 1, high)
  end
end

# solution 2
def quick_sort2(array, from = 0, to = nil)
  to = array.count - 1 if to == nil

  return if from >= to

  pivot = array[from] # take left most as initial pivot

  min = from
  max = to

  free = min

  while min < max
    if free == min
      if array[max] <= pivot # swap left with right if smaller than pivot
        array[free] = array[max]
        min += 1
        free = max
      else
        max -= 1
      end
    elsif free == max
      if array[min] >= pivot
        array[free] = array[min]
        max -= 1
        free = min
      else
        min += 1
      end
    else
      raise "Inconsistent state"
    end
  end

  array[free] = pivot

  quick_sort array, from, free - 1
  quick_sort array, free + 1, to
end

# ary = [64, 34, 25, 12, 22, 11, 90]
# quick_sort2 ary
# puts ary
