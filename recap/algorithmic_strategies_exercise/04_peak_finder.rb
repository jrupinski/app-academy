# Write a method, peak_finder(arr), that accepts an array of numbers as an arg.
# The method should return an array containing all of "peaks" of the array.
# An element is considered a "peak" if it is greater than both it's left and right neighbor.
# The first or last element of the array is considered a "peak" if it is greater than it's one neighbor.

def peak_finder(arr_num)
  peaks = []

  # check first element
  peaks << arr_num.first if arr_num.first > arr_num[1]
  
  i = 1
  while i < arr_num.length - 1
    left_side = arr_num[i - 1]
    right_side = arr_num[i + 1]
    curr_ele = arr_num[i]
    
    peaks << curr_ele if curr_ele > left_side && curr_ele > right_side
    
    i += 1
  end
  
  # check last element
  peaks << arr_num.last if arr_num.last > arr_num[-2]
  
  peaks
end

p peak_finder([1, 3, 5, 4])         # => [5]
p peak_finder([4, 2, 3, 6, 10])     # => [4, 10]
p peak_finder([4, 2, 11, 6, 10])    # => [4, 11, 10]
