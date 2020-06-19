class Octopus
  # Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to all other fish lengths
  def self.sluggish_octopus
    fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
    longest_fish = ""

    fishes.each do |fish_1|
      fishes.each do |fish_2|
        longest_fish = fish_2 if fish_2.length > fish_1.length
      end
    end

    longest_fish
  end
end


puts Octopus.sluggish_octopus