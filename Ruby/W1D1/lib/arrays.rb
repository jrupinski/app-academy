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

    new_array = Array.new(outer_arr_len) { Array.new(ele_length) }
    
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
