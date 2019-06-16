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
  
  # Return elements of Array which satisfy given condition
  def my_select(&condition_block)
    self.my_each(&condition_block)
  end
end

# tests
# my_each
p [1, 2, 6, 3].my_each  # => 1, 2, 6, 3
p [1, 2, 6, 3].my_each { |el| print "#{el * 2}, "} # => 2, 4, 12, 6

# my_select
