# 
# Given an array of unique integers and a target sum, determine whether any
# two integers in the array sum to that amount.
# Example:
# def two_sum?(arr, target_sum)
    # your code here...
# end

# arr = [0, 1, 5, 7]
# two_sum?(arr, 6) # => should be true
# two_sum?(arr, 10) # => should be false
# 
# 
class TwoSumProblem
  #
  # Brute force solution. To start with, we could check every possible pair. 
  # If we sum each element with every other, we're sure to either find the pair
  # that sums to the target, or determine that no such pair exists.
  #
  # @param [Array] arr Integers to check pairs of
  # @param [Integer] target Target number
  #
  # @return [Boolean] True if a sum of pair equals target, false otherwise
  #
  def bad_two_sum?(arr, target)
    arr.each.with_index do |ele_1, idx_1|
      arr.each.with_index do |ele_2, idx_2|
        next unless idx_1 > idx_2
        return true if ele_1 + ele_2 == target
      end
    end

    false
  end
  
end