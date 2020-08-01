require_relative "06_minmaxstackqueue"

# Given an array, and a window size w, find the maximum range (max - min) 
# within a set of w elements.

# Let's say we are given the array [1, 2, 3, 5] and a window size of 3. Here,
# there are only two cases to consider:

# 1. [1 2 3] 5
# 2. 1 [2 3 5]

# In the first case, the difference between the max and min elements of the
# window is two (3 - 1 == 2). In the second case, that difference is three 
# (5 - 2 == 3).
# We want to write a function that will return the larger of these two 
# differences.

# Time complexity:
# Queue uses a stack, and stack popping/pushing in O(1)
# Stack uses metadata to keep max, min, so it's acces is also O(1)
# Queue enqueing and dequeueing is also O(1) because of stack usage
# We move along every element of Array, and have to check every one of it,
# adding it to the queue and dequeueing it. So, O(n).
# Final Time Complexity: O(n)

# Space Complexity:
# Queue is O(n) - it uses two stacks that are arrays, but are at most 
# n (window size) length.
# max_range is O(1)
# current_range is also O(1)
# So - Space complexity is O(n) based on window size.
# 
def max_windowed_range(array, window_size)
  return nil if window_size > array.size
  queue = MinMaxStackQueue.new
  max_range = nil
  
  array.each do |ele|
    queue.enqueue(ele)
    next if queue.size < window_size
    
    current_range = queue.max - queue.min
    max_range = current_range if max_range.nil? || max_range < current_range

    queue.dequeue
  end

  max_range
end

if __FILE__ == $PROGRAM_NAME
  puts max_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  puts max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  puts max_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  puts max_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
end