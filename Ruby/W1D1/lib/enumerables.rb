class Array
  # call the block on every element of array, and returns original array
  # DO NOT USE enumerables #each method
  def my_each
    # If block given - call it on every element
    if block_given?
      for i in 0...self.length
        array_ele = self[i] 
        yield(array_ele)
      end
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

  # Return an array without elements that satisfy given condition
  def my_reject
    not_rejected = []
    if block_given?
      self.my_each { |ele| not_rejected << ele if !yield(ele) }
    end

    not_rejected
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

puts "my_reject test"
a = [2, 4, 7, 9, 10, 15]
p a.my_reject { |ele| !ele.even? } # => [2, 4, 10]
p a.my_reject { |ele| ele.even? } # => [7, 9, 15]
