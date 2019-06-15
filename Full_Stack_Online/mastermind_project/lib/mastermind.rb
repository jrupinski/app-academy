require_relative "code"

class Mastermind
  attr_reader :secret_code


  def initialize(length)
    @secret_code = Code.random(length) 
  end
  
  def print_matches(guess)
    puts "exact matches: #{@secret_code.num_exact_matches(guess)}"
    puts "near matches: #{@secret_code.num_near_matches(guess)}"
  end

  def ask_user_for_guess
    puts "Enter a code"
    guess = Code.from_string(gets.chomp)
    self.print_matches(guess)
    self.secret_code == guess
  end
end
