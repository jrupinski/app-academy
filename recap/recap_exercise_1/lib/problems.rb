require "byebug"

# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
  vowels = "aeiou"

  # create distinct word pairs
  pairs = distinct_word_pairs(words)

  # check pairs for every vowel inclusion
  pairs.each.select do |pair|
    vowels.chars.all? { |vowel| pair.downcase.include?(vowel.downcase) }
  end
end

# create distinct word pairs
def distinct_word_pairs(words)
  pairs = []

  words.each_with_index do |word_1, idx_1|
    words[idx_1 + 1..-1].each do |word_2|
      pairs << "#{word_1} #{word_2}" 
    end
  end
  
  pairs
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
  (2...num).any? do |factor_1|
    (2...num).any? do |factor_2|
      factor_1 * factor_2 == num
    end
  end
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
  pairs = []

  str_no_spaces = str.split.join("")
  (0...str_no_spaces.length - 1).each do |idx_1|

    (idx_1...str_no_spaces.length).each do |idx_2|
      pairs << str_no_spaces[idx_1..idx_2]
    end

  end

  # debugger
  bigrams.select { |bigram| pairs.include?(bigram) }
end
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])

  # Write a method, Hash#my_select, that takes in an optional proc argument
  # The method should return a new hash containing the key-value pairs that return
  # true when passed into the proc.
  # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
  #
  # Examples:
  #
  # hash_1 = {x: 7, y: 1, z: 8}
  # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
  #
  # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
  # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
  # hash_2.my_select                            # => {4=>4}
class Hash
  def my_select(&prc)
    prc ||= Proc.new { |k, v| k == v }
    self.select { |k ,v| prc.call(k, v) }
  end
end

class String
  # Write a method, String#substrings, that takes in a optional length argument
  # The method should return an array of the substrings that have the given length.
  # If no length is given, return all substrings.
  #
  # Examples:
  #
  # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
  # "cats".substrings(2)  # => ["ca", "at", "ts"]
  def substrings(length = nil)
    substrings = []

    # get all substrings
    (0...self.length).each do |idx_1|
      (idx_1...self.length).each do |idx_2|
        substrings << self[idx_1..idx_2]
      end
    end

    # select substrings with >= length; if none given - return all substrings
    if length.is_a?(Integer)
      substrings.select { |substr| substr.length == length } 
    else
      substrings
    end
  end


  # Write a method, String#caesar_cipher, that takes in an a number.
  # The method should return a new string where each char of the original string is shifted
  # the given number of times in the alphabet.
  #
  # Examples:
  #
  # "apple".caesar_cipher(1)    #=> "bqqmf"
  # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
  # "zebra".caesar_cipher(4)    #=> "difve"
  def caesar_cipher(num)
    alpha = ("a".."z").to_a

    words = self.split
    words.map! do |word|
      shifted_word = ""

      word.chars do |char|
        shifted_word += shift_char(char, num)
      end

      shifted_word
    end
    
    words.join(" ")
  end

  def shift_char(char, num)
    alpha = ("a".."z").to_a

    old_idx = alpha.index(char)
    new_idx = (old_idx + num) % alpha.length

    alpha[new_idx]
  end
end
