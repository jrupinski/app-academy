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
  def self.exponentation_ver_1(base, exponent)
    return 1 if exponent == 0
    base * exponentation_ver_1(base, exponent - 1)
  end

  # recursion 2
  # exp(b, 0) = 1
  # exp(b, 1) = b
  # exp(b, n) = exp(b, n / 2) ** 2             [for even n]
  # exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
  def self.exponentation_ver_2(base, exponent)
    return 1 if exponent == 0
    return base if exponent == 1
    exponentation_result = 0
    if exponent.even?
      even_exponentation = exponentation_ver_2(base, exponent / 2) ** 2 
      exponentation_result = even_exponentation
    else
      odd_exponentation = base * (exponentation_ver_2(base, (exponent - 1) / 2) ** 2)
      exponentation_result = odd_exponentation
    end

    exponentation_result
  end
end