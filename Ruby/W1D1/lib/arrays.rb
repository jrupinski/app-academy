require "byebug"
require_relative "./enumerables.rb"

class Array
  # Turn multi-dimensional array into a flat 1-D array
  def my_flatten
    # base case
    return self if self.is_a?(Array) == false
    flattened = []

    self.my_each do |ele|
      if !ele.is_a?(Array)
        flattened += [ele]
      else
        flattened += ele.my_flatten
      end
    end

    flattened
  end

  # return a new array with self.length elements; each ele is 
  # (args.length + 1) long. Each element is an array with n-th element
  # from every argument array and self.
  def my_zip(*arg)
    outer_arr_len = self.length
    ele_length = arg.length + 1

    # initialize empty array with proper sizing
    new_array = Array.new(outer_arr_len) { Array.new(ele_length) }
    
    # get elements from self
    (0...outer_arr_len).each { |i| new_array[i][0] = self[i] }

    # get elements from arguments
    # TODO: FIX THIS
    # (0...outer_arr_len).each { |i| new_array[i] << arg.my_flatten[i] }

    new_array
  end

  def my_rotate

  end

  def my_join

  end

  def my_reverse

  end
end

# Tests
test = [1, [2], [[3]], [4], [[[[[5]]]]]]

puts "#my_flatten test"
p test.my_flatten # => [1, 2, 3, 4, 5]
p ["test", "testing"].my_flatten # => ["test", "testing"]

puts "#my_zip test"
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]