require "byebug"

class Hangman
  # PART 1
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

  # PART 2
  def try_guess(char)
    if self.already_attempted?(char)
      puts "that was already attempted"
      return false
    end

    attempted_chars << char

    if @secret_word.include?(char)
      indices = self.get_matching_indices(char)
      self.fill_indices(char, indices)
    else
      self.remaining_incorrect_guesses -= 1
    end

    true
  end

  def ask_user_for_guess
    print "Enter a char: "
    guess = gets.chomp.to_s
    self.try_guess(guess)
  end

  def win?
    # debugger
    if @guess_word.join("") == @secret_word
      puts "YOU WIN!"
      return true
    end
    
    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "YOU LOSE"
      return true
    end

    false
  end

  def game_over?
    if self.lose? || self.win?
      puts "Secret word: #{@secret_word}"
      true
    else
      false
    end
  end
end
