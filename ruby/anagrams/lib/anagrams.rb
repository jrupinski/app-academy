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
    return false unless word_1.length == word_2.length
    anagrams = word_1.permutation

    anagrams.each { |anagram| return true if anagram == word_2}

    false
  end

  #
  # Write a method #second_anagram? that iterates over the first string. 
  # For each letter in the first string, find the index of that letter in the 
  # second string (hint: use Array#find_index) and delete at that index. 
  # The two strings are anagrams if an index is found for every letter and the
  # second string is empty at the end of the iteration.
  #
  # @param [String] word_1 first word
  # @param [String] word_2 second word
  #
  # @return [Boolean] true if both words are anagrams of each other
  #
  def second_anagram?(word_1, word_2)
    # debugger
    raise ArgumentError unless word_1.is_a?(String) && word_2.is_a?(String)
    return false unless word_1.length == word_2.length

    word_2_chars = word_2.chars
    word_1.each_char do |word_1_char|
      index = word_2_chars.find_index(word_1_char)
      word_2_chars.delete_at(index) unless index.nil?
    end

    word_2_chars.empty?
  end

  #
  # Write a method #third_anagram? that solves the problem by sorting both 
  # strings alphabetically. The strings are then anagrams if and only if the 
  # sorted versions are the identical.
  #
  # @param [String] word_1 first word
  # @param [String] word_2 second word
  #
  # @return [Boolean] true if both words are anagrams of each other
  #
  def third_anagram?(word_1, word_2)
    # I used merge sort; time complexity may vary between different algorithms 
    word_1.merge_sort == word_2.merge_sort
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

  #
  # Sort String and return sorted version as an Array
  #
  # @return [Array] Sorted String
  #
  def merge_sort
    return [self] if self.length <= 1
    
    mid = self.length / 2
    left = self[0...mid].merge_sort
    right = self[mid..-1].merge_sort
    sorted = []

    until left.empty? || right.empty?
      if left[0] >= right[0]
        sorted << right.shift
      else
        sorted << left.shift
      end
    end

    sorted += left
    sorted += right

    sorted
  end
end