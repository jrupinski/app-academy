require "byebug"
require "set"

#
# Build a chain of words connecting the first to the second. 
# Each word in the chain must be in the dictionary and every step along 
# the chain changes exactly one letter from the previous word.
#
class WordChainer
  def initialize(dictionary_file_name)
    dictionary_file = File.read(dictionary_file_name).split("\n")
    @dictionary = Set.new(dictionary_file)

    puts @dictionary
  end

  #
  # Returns all words in the dictionary one letter different than the current word
  #
  # @param [String] word A word
  #
  # @return [Array] Array of adjacent words
  #
  def adjacent_words(word)
    @dictionary.select do |dict_word| 
      same_length?(word, dict_word) && one_char_different?(word, dict_word)
    end
  end

  #
  # Check if two strings are the same length
  # Examples:
  # same_length?("foo", "bar") # true
  # same_length?("longest", "word") # false
  #
  # @param [String] word_1 word
  # @param [String] word_2 second word for comparison
  #
  # @return [Boolean] True if words are same length, false otherwise
  #
  def same_length?(word_1, word_2)
    word_1.length == word_2.length
  end

  #
  # Check if two Strings are different by one char only
  # Examples:
  # one_char_different("cat", "mat") # true
  # one_char_different("cat", "cats") # false
  # one_char_different("foo", "bar") # false
  #
  # @param [String] word_1 word string
  # @param [String] word_2 Second word for comparison
  #
  # @return [Boolean] True if words are different by one char, false otherwise
  #
  def one_char_different?(word_1, word_2)
    unless !same_length?(word_1, word_2)
      (0...word_1.length).one? { |i| word_1[i] != word_2[i] }
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  WordChainer.new(ARGV[0] || "dictionary.txt")
end