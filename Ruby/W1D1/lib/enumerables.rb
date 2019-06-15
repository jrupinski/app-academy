class Array
  # call the block on every element of array, and returns original array
  # DO NOT USE enumerables #each method
  def my_each(&block)
    array_length = self.length
    for i in 0...array_length
      puts "#{self[i]}"
    end
  end
end

# tests
[1, 2, 6, 3].my_each