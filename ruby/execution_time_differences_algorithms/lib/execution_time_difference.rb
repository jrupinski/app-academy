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

puts "my_min - O(n^2)"
puts my_min([ 0, 3, 5, 4, -5, 10, 1, 90 ])
puts "my_min - O(n)"
puts my_min_iterate_once([ 0, 3, 5, 4, -5, 10, 1, 90 ])
