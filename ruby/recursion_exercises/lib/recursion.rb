require "byebug"

class Recursion
  # This method crashes before stack overflows, so one can read the stack trace
  # STACK TRACE METHOD START
  MAX_STACK_SIZE = 200
  tracer = proc do |event|
    if event == 'call' && caller_locations.length > MAX_STACK_SIZE
      fail "Probable Stack Overflow"
    end
  end
  set_trace_func(tracer)
  # STACK TRACE METHOD END

  # Warmup

  # Range
  # Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
  # Write both a recursive and iterative version of sum of an array.
  def self.range_recursive(start, end_range)
    return [] if end_range < start || start == end_range
    [start] + range_recursive(start + 1, end_range)
  end

  def self.range_iterative(start, end_range)
    (start...end_range).to_a
  end

  # Exponentiation
  # Write two versions of exponent that use two different recursions:
  # Note that for recursion 2, you will need to square the results of exp(b, n / 2) and (exp(b, (n - 1) / 2). Remember that you don't need to do anything special to square a number, just calculate the value and multiply it by itself. So don't cheat and use exponentiation in your solution.

  # recursion 1
  # exp(b, 0) = 1
  # exp(b, n) = b * exp(b, n - 1)
  def self.exponent_ver_1(base, power)
    return 1 if power == 0
    base * exponent_ver_1(base, power - 1)
  end

  # recursion 2
  # exp(b, 0) = 1
  # exp(b, 1) = b
  # exp(b, n) = exp(b, n / 2) ** 2             [for even n]
  # exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
  def self.exponent_ver_2(base, power)
    return 1 if power == 0
    return base if power == 1
    exponent_result = 0
    if power.even?
      even_exponent = exponent_ver_2(base, power / 2) ** 2 
      exponent_result = even_exponent
    else
      odd_exponent = base * (exponent_ver_2(base, (power - 1) / 2) ** 2)
      exponent_result = odd_exponent
    end

    exponent_result
  end

  #
  # Create a deep duplicate copy of multi-dimensional Array
  #
  # @param [Array] multi_dim_array Multi-dimensional Array
  #
  # @return [Array] Independent duplicate of argument Array
  #
  def self.deep_dup(multi_dim_array)
    return multi_dim_array.dup if !multi_dim_array.is_a?(Array)
    multi_dim_array.map { |array| deep_dup(array) } 
  end

  #
  # Fibonacci method, recursive implementation
  # The method should take in an integer n and return the first n Fibonacci numbers in an array.
  #
  # @param [Integer] n Number of fibonacci numbers to return 
  #
  # @return [Array] Array of first n fibonacci numbers
  #
  def self.fibonacci_recursive(n)
    if n <= 0
      return []
    elsif n == 1
      return [0]
    elsif n == 2
      return [0, 1]
    end

    list = Recursion.fibonacci_recursive(n - 1)
    list << list[-1] + list[-2]
  end

  #
  # Fibonacci method, iterative implementation
  # The method should take in an integer n and return the first n Fibonacci numbers in an array.
  #
  # @param [Integer] n Number of fibonacci numbers to return 
  #
  # @return [Array] Array of first n fibonacci numberes
  #
  def self.fibonacci_iterative(n)
    return [] if n <= 0
    return [0] if n == 1

    list = [0, 1]
    (n - 2).times do |num|
      list << list[-1] + list[-2]
    end

    list
  end

  #
  # Recursive binary search: bsearch(array, target). Note that binary search only works on sorted arrays
  #
  # @return [Integer] Index of target in Array
  #
  def self.bsearch(array, target)
    return nil if array.empty?

    middle = array.length / 2
    less_than = array.take(middle)
    more_than = array.drop(middle + 1)
    
    if array[middle] == target
      return middle
    elsif target < array[middle]
      bsearch(less_than, target)
    elsif target > array[middle]
      # keep it in a different variable to keep OG array indexing, not sub-array's
      sub_answer = bsearch(more_than, target)
      sub_answer.nil? ? nil : sub_answer + (middle + 1)
    end
  end

  #
  # Recursive merge_sort implementation. Sort an array using Merge sort algorithm.
  #
  # @param [Array] array An unsorted array
  #
  # @return [Array] Sorted array
  #
  def self.merge_sort(array)
    return array if array.length <= 1

    middle = array.length / 2
    left = array.take(middle)
    right = array.drop(middle)
    sorted = []
    merge(merge_sort(left), merge_sort(right))
  end

  def self.merge(array_1, array_2)
    sorted = []
    arr_1_idx, arr_2_idx = 0, 0

    until sorted.length == (array_1.length + array_2.length)
      arr_1_ele = array_1[arr_1_idx] 
      arr_2_ele = array_2[arr_2_idx] 

      if arr_1_ele.nil? || arr_2_ele.nil?
        sorted << (arr_1_ele || arr_2_ele)
        arr_1_idx += 1
        arr_2_idx += 1
      elsif arr_1_ele < arr_2_ele
        sorted << arr_1_ele
        arr_1_idx += 1
      else
        sorted << arr_2_ele
        arr_2_idx += 1
      end
    end

    sorted
  end
end