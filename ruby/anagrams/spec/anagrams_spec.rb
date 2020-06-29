require "rspec"
require "anagrams"

describe Anagrams do
  subject(:test) { Anagrams.new }
  # Write a method #first_anagram? that will generate
  # and store all the possible anagrams of the first string. 
  # Check if the second string is one of these.
  describe "first_anagram?" do
    it "rejects wrong input" do
      expect { test.first_anagram?("dog", 69) }.to raise_error(ArgumentError)
      expect { test.first_anagram? }.to raise_error(ArgumentError)
    end
    
    it "compares two words if they're anagrams" do
      expect(test.first_anagram?("dog", "god")).to be true
      expect(test.first_anagram?("dog", "cat")).to be false 
    end
  end
end