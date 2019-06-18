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
  def my_zip(*args)
    outer_arr_len = self.length
    ele_length = args.length + 1

    # initialize empty array with proper sizing
    new_array = Array.new(outer_arr_len) { Array.new(ele_length) }
    
    # enter outer array, then swap first values with first values from self
    (0...outer_arr_len).to_a.my_each do |i|
      self_sub_array = self[i]
      new_array_sub_array = new_array[i]
      new_array_sub_array[0] = self_sub_array
    end

    # get every value from args into new_array
    # from arg: ele of index n goes to new_array's inner array of index n
    args.my_each do |arg|
      (0...arg.length).to_a.my_each do |ele_idx|
        # debugger
        arg_ele = arg[ele_idx]
        inner_arr = 0
        new_array_ele = new_array[ele_idx][inner_arr]

        until new_array_ele.nil?
          inner_arr += 1
          new_array_ele = new_array[ele_idx][inner_arr]
        end
        
        new_array[ele_idx][inner_arr] = arg_ele
      end
    end

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
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]