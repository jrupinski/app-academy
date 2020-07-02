#
# determines if two given words are anagrams. This means that the letters 
# in one word can be rearranged to form the other word.
#
# @param [String] word_1 first word
# @param [String] word_2 second word
#
# @return [Boolean] true if both words are anagrams of each other
#
class Anagrams
  def first_anagram?(word_1, word_2)
    raise ArgumentError unless word_1.is_a?(String) && word_2.is_a?(String)
    anagrams = word_1.permutation

    anagrams.each { |anagram| return true if anagram == word_2}

    false
  end
end

# monkey patch to make it easier for myself 
class String
  #
  # Permutates the string, n-length permutations
  #
  # @return [Array] Permutated strings
  #
  def permutation
    return [self] if self.length <= 1
    # reduce word by 1 letter on the left by each iteration
    old_permutations = self[1...self.length].permutation
    new_permutations = []

    # insert new char (first letter of current word) in between every char of existing permutations
    old_permutations.each do |permutation|
      for i in (0..permutation.length) do
        new_permutations << permutation.dup.insert(i, self[0])
      end
    end

    new_permutations
  end
end