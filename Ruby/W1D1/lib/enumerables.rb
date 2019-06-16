class Array
  # call the block on every element of array, and returns original array
  # DO NOT USE enumerables #each method
  def my_each(&block)
    # If block given - call it on every element
    if block_given?
      for i in 0...self.length
        array_ele = self[i]
        block.call(array_ele)
      end
    end

    self
  end
  
  # Return elements of Array which satisfy given condition
  def my_select(&condition_block)
    # TODO
  end
end

# tests
# my_each
p [1, 2, 6, 3].my_each  # => 1, 2, 6, 3
p [1, 2, 6, 3].my_each { |el| print "#{el * 2}, "} # => 2, 4, 12, 6

# my_select
