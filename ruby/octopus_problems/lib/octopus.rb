class Octopus
  FISHES = ['fish', 'fiiish', 'fiiiiish', 'fiiiish',
   'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

   TILES_ARRAY = [
     "up", "right-up", "right", "right-down", "down", "left-down", "left",
      "left-up" 
    ]

    TILES_HASH = {
      "up" => 0,
      "right-up" => 1,
      "right" => 2,
      "right-down" => 3,
      "down" => 4,
      "left-down" => 5,
      "left" => 6,
      "left-up" => 7
    }

  #
  # Given a tile direction, iterate through a tiles array to return
  # the tentacle number (tile index) the octopus must move.
  # This should take O(n) time.
  #
  def self.slow_dance(direction, dance_floor = TILES_ARRAY)
    raise ArgumentError unless TILES_ARRAY.include?(direction)
    TILES_ARRAY.each_with_index do |tile, tentacle_idx|
      return tentacle_idx if tile == direction
    end
  end


  #
  # Use a different data structure and write a new function so that you can
  # access the tentacle number in O(1) time.
  #
  def self.constant_dance(direction, dance_floor = TILES_HASH)
    raise ArgumentError unless TILES_ARRAY.include?(direction)
    TILES_HASH[direction]
  end
  # Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to all other fish lengths
  def self.sluggish_octopus
    longest_fish = ""

    FISHES.each do |fish_1|
      FISHES.each do |fish_2|
        longest_fish = fish_2 if fish_2.length > fish_1.length
      end
    end

    longest_fish
  end

  # Find the longest fish in O(n log n) time. 
  def self.dominant_octopus
    sorted_fish = self.merge_sort(FISHES)
    sorted_fish.last
  end

  # Find the longest fish in O(n) time
  def self.clever_octopus
    longest_fish = FISHES.first
    FISHES.each { |fish| longest_fish = fish if fish.length > longest_fish.length }
    longest_fish
  end

  private

  # Merge sort based on string length
  def self.merge_sort(arr)
    # debugger
    return arr if arr.length <= 1
    mid = (arr.length / 2).floor
    left = arr[0...mid]
    right = arr[mid...arr.length]

    self.merge(
      self.merge_sort(left),
      self.merge_sort(right)
    )
  end

  # Merge string Arrays based on their length
  def self.merge(left, right)
    # NB: In Ruby, shift is an O(1) operation. This is not true of all languages.
    merged = []
    
    until left.empty? || right.empty?
      if left.first.length > right.first.length
        merged << right.shift
      else
        merged << left.shift
      end
    end
    
    merged + left + right
    
  # # Recursive approach
  #   return right if left.empty?
  #   return left if right.empty?

  #   if left.first.length < right.first.length
  #     [left.first] + self.merge(left[1..-1], right)
  #   else
  #     [right.first] + self.merge(left, right[1..-1])
  #   end
  end
end

puts "Finding longest fish:"
puts "O(n^2) time:"
puts Octopus.sluggish_octopus
puts "O(n log n) time:"
puts Octopus.dominant_octopus
puts "O(n) time:"
puts Octopus.clever_octopus

puts
puts "Dancing octopus!"
puts "Slow dance:"
puts Octopus.slow_dance("up")
# > 0
puts Octopus.slow_dance("right-down")
# > 3
puts "Constant dance:"
puts Octopus.constant_dance("up")
# > 0
puts Octopus.constant_dance("right-down")
# > 3