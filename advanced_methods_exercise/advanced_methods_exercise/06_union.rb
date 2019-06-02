# Write a method, union, that accepts any number of arrays as arguments.
# The method should return an array containing all elements of the given arrays.
def union(*arr)
  # main_arr = []
  # arr.each do |sub_array|
  #   sub_array.each { |ele| main_arr << ele }
  # end
  
  # main_arr

  arr.flatten
end

# p union(["a", "b", "c"])
p union(["a", "b"], [1, 2, 3]) # => ["a", "b", 1, 2, 3]
p union(["x", "y"], [true, false], [20, 21, 23]) # => ["x", "y", true, false, 20, 21, 23]
