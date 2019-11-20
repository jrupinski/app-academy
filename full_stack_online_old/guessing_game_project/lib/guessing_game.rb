require "byebug"

class GuessingGame
  def initialize(min, max)
    @secret_num = rand(min..max)
    @num_attempts = 0
    @game_over = false
  end

  def num_attempts
    @num_attempts
  end

  def game_over?
    @game_over
  end

  def check_num(num)
    @num_attempts += 1
    
    # debugger
    if num > @secret_num
      puts "too big"
    elsif num < @secret_num
      puts "too small"
    else
      puts "you win"
      @game_over = true
    end
  end

  def ask_user
    puts "enter a number"
    user_num = gets.chomp.to_i
    self.check_num(user_num)
  end
end
