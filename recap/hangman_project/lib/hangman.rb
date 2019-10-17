class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
     @secret_word = Hangman.random_word
     @guess_word = Array.new(@secret_word.length, "_")
     @attempted_chars = []
     @remaining_incorrect_guesses = 5
  end

  attr_accessor :secret_word, :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def already_attempted?(char)
    self.attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    self.secret_word.each_char.with_index { |c, i| indices << i if c == char }
    indices
  end

  def fill_indices(char, indices)
    indices.each { |i| @guess_word[i] = char }
  end

  
end
