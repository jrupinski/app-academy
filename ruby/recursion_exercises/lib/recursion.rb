class Recursion
  # Warmup
  # Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
  # Write both a recursive and iterative version of sum of an array.
  def self.range_recursive(start, end_range)
    return [] if end_range < start || start == end_range
    [start] + range_recursive(start + 1, end_range)
  end

  def self.range_iterative(start, end_range)
    (start...end_range).to_a
  end
end