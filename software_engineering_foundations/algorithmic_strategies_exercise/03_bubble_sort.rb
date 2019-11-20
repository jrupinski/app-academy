# Reimplement the bubble sort outlined in the preceding lecture.
# The bubble_sort method should accept an array of numbers and arrange the elements in increasing order.
# The method should return the array.
# Do not use the built-in Array#sort

def bubble_sort(arr_num)
  sorted = false

  while !sorted
    sorted = true

    i = 0
    while i < arr_num.length - 1
      ele = arr_num[i]
      next_ele = arr_num[i + 1]
      
      if ele > next_ele
        arr_num[i], arr_num[i + 1] = arr_num[i + 1], arr_num[i]
        sorted = false
      end

      i += 1
    end
  end

  arr_num
end

p bubble_sort([2, 8, 5, 2, 6])      # => [2, 2, 5, 6, 8]
p bubble_sort([10, 8, 7, 1, 2, 3])  # => [1, 2, 3, 7, 8, 10]