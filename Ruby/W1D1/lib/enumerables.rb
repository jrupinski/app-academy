class Array
  # call the block on every element of array, and returns original array
  # DO NOT USE enumerables #each method
  def my_each
    # If block given - call it on every element
    for i in 0...self.length
      array_ele = self[i]
      yield(array_ele) if block_given?
    end

    self
  end
  
  # Return elements of Array which satisfy given condition; use #my_each
  def my_select
    selected = []
    if block_given?
      self.my_each do |ele|
        selected << ele if yield(ele)
      end
    end

    selected
  end
end

# TESTS
puts "my_each test"
a = [1, 2, 6, 3]
p a.my_each  # => 1, 2, 6, 3
p a.my_each { |el| print "#{el * 2}, "} # => 2, 4, 12, 6

puts "my_select test"
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []