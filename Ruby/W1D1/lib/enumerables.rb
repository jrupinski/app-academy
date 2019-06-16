class Array
  # call the block on every element of array, and returns original array
  # DO NOT USE enumerables #each method
  def my_each(&block)
    array_length = self.length
    for i in 0...array_length
      if block
        block.call(self[i])
      else
        puts self[i]
      end
    end
    
    self
  end
end


# tests
p [1, 2, 6, 3].my_each  # => 1, 2, 6, 3
p [1, 2, 6, 3].my_each { |el| puts "#{el * 2}"} # => 2, 4, 12, 6