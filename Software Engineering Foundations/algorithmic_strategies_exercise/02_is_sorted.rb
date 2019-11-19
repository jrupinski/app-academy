# Write a method, is_sorted?(arr), that accepts an array of numbers as an arg.
# The method should return true if the elements are in increasing order, false otherwise.
# Do not use the built-in Array#sort in your solution :)

# ONE LINER:
# def is_sorted?(arr_num)
#   arr_num.each.with_index.none? {|ele, idx| arr_num[idx] > arr_num[idx + 1] if idx < arr_num.length - 1 }
# end

def is_sorted?(arr_num)
  arr_num.each.with_index.none? do |ele, i|
    if i < arr_num.length - 1
      arr_num[i] > arr_num[i + 1]
    end
  end
end

p is_sorted?([1, 4, 10, 13, 15])       # => true
p is_sorted?([1, 4, 10, 10, 13, 15])   # => true
p is_sorted?([1, 2, 5, 3, 4 ])         # => false
