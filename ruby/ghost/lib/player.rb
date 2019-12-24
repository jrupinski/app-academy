require "byebug"
# Player class
class Player
  attr_reader :name
  
  class InvalidNameError < ArgumentError; end
  
  def initialize(name)
    raise InvalidNameError if !name.is_a?(String)
    @name = name
  end
  
  def guess
    print "enter a 1-letter guess: "
    alert_invalid_guess(gets.chomp) ? false : true
  end
  
  def alert_invalid_guess(guess)
    alphabet = ("a".."z").to_a

    if !alphabet.include?(guess.downcase)
      puts "Invalid guess"
      true
    else
      false
    end
  end
end