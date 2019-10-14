class GuessingGame
  def initialize(min, max)
    @min = min
    @max = max
    @secret_num = rand(min..max)
    @num_attempts = 0
    @game_over = false
  end

  attr_accessor :num_attempts

  def game_over?
    @game_over
  end

  def check_num(num)
    if num == @secret_num
      @game_over = true
      p "you win"
      return self.game_over?

    elsif num > @secret_num
      p "too big"

    else
      p "too small"
    end
  
  @num_attempts += 1    
  end

  def ask_user
    p "enter a number: "
    num = gets.chomp.to_i
    self.check_num(num)
  end
end
