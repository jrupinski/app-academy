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
      self.my_each { |ele| selected << ele if yield(ele) }
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
  # return true if any element satisfies condition; else return false
  def my_any?
    if block_given?
      self.my_each { |ele| return true if yield(ele) }
    end

    false
  end
end

# TESTS
test = [2, 4, 7, 9, 10, 15]

puts "my_each test"
p test.my_each  # => [2, 4, 7, 9, 10, 15]
p test.my_each { |el| print "#{el * 2}, "} # => [2, 4, 7, 9, 10, 15]

puts "my_select test"
p test.my_select { |num| num > 7 } # => [9, 10, 15]
p test.my_select { |num| num == 5 } # => []

puts "my_reject test"
p test.my_reject { |ele| !ele.even? } # => [2, 4, 10]
p test.my_reject { |ele| ele.even? } # => [7, 9, 15]

puts "my_any? test"
p test.my_any? { |ele| !ele.even? } # => true
p test.my_any? { |ele| ele == 999 } # => false
