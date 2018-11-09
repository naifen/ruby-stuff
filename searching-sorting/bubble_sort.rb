# simplest sorting algorithm, repeatedly swapping the adjacent elements if they are in wrong order.
# Worst and Average Case Time Complexity: O(n*n). Worst case occurs when array is reverse sorted.
# Best Case Time Complexity: O(n). Best case occurs when array is already sorted.

def bubble_sort(array)
  len = array.length

  # * compare every element in range 0 to 6, find largest element for index 6
  # * compare every element in range 0 to 5, find largest element for index 5
  # ...
  # * till range 0..0
  for i in (1..(len - 1))
    for j in (0..(len - i - 1))
      if array[j] > array[j + 1]
        array[j], array[j + 1] = array[j + 1], array[j]
      end
    end
  end
end
