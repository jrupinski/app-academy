require "byebug"
# Given a list of integers find the smallest number in the list.
# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# my_min(list)  # =>  -5
#
# Compares each element to every other element of the list.
# Return the element if all other elements in the array are larger.
#
def my_min(list)
  min = list[0]

  list.each_with_index do |ele_1, idx_1|
    list.each_with_index do |ele_2, idx_2|
      min = ele_1 if (min > ele_1 && idx_2 > idx_1)
    end
  end

  min
end


#
# Rewrote the function to iterate through the list just once while keeping
# track of the minimum.
#
# @param [<Type>] list <description>
#
# @return [<Type>] <description>
#
def my_min_iterate_once(list)
  min = list[0]

  list.each { |ele| min = ele if min > ele }

  min
end


# Largest Contiguous Sub-sum
# You have an array of integers and you want to find the largest contiguous 
# (together in sequence) sub-sum. Find the sums of all contiguous sub-arrays 
# and return the max.
# Example:
#  list = [5, 3, -7]
#     largest_contiguous_subsum(list) # => 8

#     # possible sub-sums
#     [5]           # => 5
#     [5, 3]        # => 8 --> we want this one
#     [5, 3, -7]    # => 1
#     [3]           # => 3
#     [3, -7]       # => -4
#     [-7]          # => -7

# Phase I
# Write a function that iterates through the array and finds all
# sub-arrays using nested loops. First make an array to hold all sub-arrays. 
# Then find the sums of each sub-array and return the max.
# Discuss the time complexity of this solution.
def largest_contiguous_subsum(list)
  sub_arrays = []

  list.each_with_index do |ele_1, idx_1|
    array = []
    list.each_with_index do |ele_2, idx_2|
      next unless idx_2 >= idx_1
      array << ele_2
      sub_arrays << array.dup
    end
  end

  max_sub_arr = nil
  sub_arrays.each do |sub_arr|
    sum = sub_arr.sum
    max_sub_arr = sum if max_sub_arr.nil? || max_sub_arr < sum
  end

  max_sub_arr
end


#
# Let's make a better version. Write a new function using O(n) time 
# with O(1) memory. Keep a running tally of the largest sum. To accomplish 
# this efficient space complexity, consider using two variables. One variable
# should track the largest sum so far and another to track the current sum. 
# We'll leave the rest to you.
#
def largest_contiguous_subsum_phase_2(list)
  # debugger
  max_sub_sum = list.first
  current = list.first

  (1...list.length).each do |i|
    current = 0 if current < 0
    current += list[i]
    max_sub_sum = current if current > max_sub_sum 
  end
  
  max_sub_sum
end


puts "my_min - O(n^2):"
puts my_min([ 0, 3, 5, 4, -5, 10, 1, 90 ])
puts "my_min - O(n):"
puts my_min_iterate_once([ 0, 3, 5, 4, -5, 10, 1, 90 ])

puts "Largest Contiguous Sub-sum - phase I:"
list = [5, 3, -7]
puts largest_contiguous_subsum(list) # => 8
list = [2, 3, -6, 7, -6, 7]
puts largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])
list = [-5, -1, -3]
puts largest_contiguous_subsum(list) # => -1 (from [-1])

puts
puts "Largest Contiguous Sub-sum - phase II:"
list = [5, 3, -7]
puts largest_contiguous_subsum_phase_2(list) # => 8
list = [2, 3, -6, 7, -6, 7]
puts largest_contiguous_subsum_phase_2(list) # => 8 (from [7, -6, 7])
list = [-5, -1, -3]
puts largest_contiguous_subsum_phase_2(list) # => -1 (from [-1])