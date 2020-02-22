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
  end

  #
  # Enumerate all the words that are reachable from source to target, changing one char at a time
  #
  # @param [String] source source String
  # @param [String] target target String, destination
  #
  # @return [Array] Array including every word from breadth first enumeration of words that you can reach from the source
  #
  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty? || all_seen_words.include?(target)
      explore_current_words
    end

    build_path(target).reverse
  end

  private

  #
  # Accessor for all_seen_words hash
  #
  # @return [Array] keys of @all_seen_words
  #
  def all_seen_words
    @all_seen_words.keys
  end

  #
  # Build an Array that shows the path to a target word from modifying the source word
  #
  # @param [String] target Target word
  #
  # @return [Array] Array with a path 
  #
  def build_path(target)
    return [] if target.nil?
    path = [target]
    path += build_path(@all_seen_words[target])
  end
  
  #
  # Explore every adjacent word of current word/words, and add them to a list
  #
  # @return [Array] Array of every word that's possible to reach from current word
  #
  def explore_current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).map do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)
        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end

    # uncomment to show every word and it's source
    # # print current words and where they came from(source word)
    # new_current_words.each do |word|
    #   print "#{word} => #{@all_seen_words[word]}\n"
    # end

    @current_words = new_current_words
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