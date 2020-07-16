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
    return false if arr.length <= 1

    arr.each.with_index do |ele_1, idx|
      arr[idx + 1...arr.length - 1].each do |ele_2|
        return true if ele_1 + ele_2 == target
      end
    end

    false
  end
  
  #
  # Write a second solution, called okay_two_sum?, which uses sorting. 
  # Make sure it works correctly.
  #
  # @param [Array] arr Integers to check pairs of
  # @param [Integer] target Target number
  #
  # @return [Boolean] True if a sum of pair equals target, false otherwise
  #
  def okay_two_sum?(arr, target)
    return false if arr.length <= 1
    sorted_arr = arr.sort
    start_idx, end_idx = 0, arr.length - 1

    while start_idx < end_idx
      case (sorted_arr[start_idx] + sorted_arr[end_idx]) <=> target
      when -1 then start_idx += 1
      when 0 then return true
      when 1 then end_idx -= 1
      end
    end

    false
  end


  # Finally, it's time to bust out the big guns: a hash map. Remember, a
  # hash map has O(1) #set and O(1) #get, so you can build a hash out of each of
  # the n elements in your array in O(n) time. That hash map prevents you from 
  # having to repeatedly find values in the array; now you can just look them up
  # instantly.
  #
  # @param [Array] arr Integers to check pairs of
  # @param [Integer] target Target number
  #
  # @return [Boolean] True if a sum of pair equals target, false otherwise
  #
  def two_sum?(arr, target)
    hash_map = {}

    arr.each do |ele|
      return true if hash_map.has_key?(target - ele)
      hash_map[ele] = true
    end

    false
  end
end