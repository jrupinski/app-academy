class Octopus
  FISHES = ['fish', 'fiiish', 'fiiiiish', 'fiiiish',
   'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

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