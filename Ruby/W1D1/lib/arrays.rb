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

  def my_zip

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
