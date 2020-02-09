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
  # @return [Array] Array of first n fibonacci numberes
  #
  def self.fibonacci_recursive(n)
    case n
      when -Float::INFINITY..0
        return 0
      when 1
        return 1
    end
    
    list = []
    # TODO: Make each number here go into a list, without using arrays as arguments
    # Turns out it's not as easy as I thought it would be
    # TODO: Fix duplicates; Fix going into the whole recursion twice
      list.append(Recursion.fibonacci_recursive(n - 1) + Recursion.fibonacci_recursive(n - 2))
      p list
      Recursion.fibonacci_recursive(n - 1) + Recursion.fibonacci_recursive(n - 2)
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
    # TODO
  end
end