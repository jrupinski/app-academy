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
    # initialize empty array with proper sizing
    outer_arr_len = self.length
    inner_arr_len = args.length + 1
    new_array = Array.new(outer_arr_len) { Array.new(inner_arr_len) }
    
    zip_self_values(new_array)
    zip_args_values(*args, new_array)
 
    new_array
  end

  # enter outer array, then swap first values with first values from self
  def zip_self_values(array)
    (0...array.length).to_a.my_each do |i|
      self_ele = self[i]
      array_sub_array = array[i]
      array_sub_array[0] = self_ele
    end
  end

  # get every value from args into array after self argument values
  # each argument's ele goes into array[index_of(ele)], else nil
  def zip_args_values(*args, array)
    args.my_each do |arg|
      (0...arg.length).to_a.my_each do |ele_idx|
        # don't overstep the arrays in array
        break if ele_idx >= array.length 

        # don't overwrite self's values in array
        inner_arr = 0
        until array[ele_idx][inner_arr].nil?
          inner_arr += 1
          array_ele = array[ele_idx][inner_arr]
        end

        array[ele_idx][inner_arr] = arg[ele_idx]
      end
    end
  end
  
  # Rotate array. By default, the array should rotate by one element.
  # If a negative value is given, the array is rotated in the opposite direction.
  def my_rotate(amt = 1)  
    return self if amt.zero?
        
    rotated = self.clone
    if amt.positive?
      rotated << rotated.shift
      rotated.my_rotate(amt - 1)
    else
      rotated.unshift(rotated.pop)
      rotated.my_rotate(amt + 1)
    end
  end

  def my_join(char = "")
    string = ""
    
    self.my_each do |ele|
      string += ele.to_s + char
    end

    string.chop
  end

  def my_reverse
    reversed = []
    last_idx = self.length - 1
    starting_idx = 0

    while last_idx >= starting_idx
      reversed << self[last_idx]
      last_idx -= 1
    end

    reversed
  end
end

# Tests

puts "#my_flatten test"
test = [1, [2], [[3]], [4], [[[[[5]]]]]]
p test.my_flatten # => [1, 2, 3, 4, 5]
p ["test", "testing"].my_flatten # => ["test", "testing"]

puts "#my_zip test"
a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
c = [10, 11, 12]
d = [13, 14, 15]

p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

puts "#my_rotate test"
a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

puts "#my_join test"
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

puts "my_reverse test"
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]