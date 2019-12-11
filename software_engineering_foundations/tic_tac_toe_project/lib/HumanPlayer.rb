require "byebug"
#
# Player class for Tic Tac Toe game
#
class HumanPlayer
  attr_reader :mark_value

  def initialize(mark_value)
    @mark_value = mark_value
  end

  def get_position
    p "current mark: #{self.mark_value}"
    print "Enter row and column (separated with space): "
    position = gets.chomp
    
    begin
      valid_format?(position)
    rescue => error
      puts "#{error.message}"
      return nil
    end

    row = position.split(" ").first.to_i
    col = position.split(" ").last.to_i
    [row, col]
  end

  def valid_format?(position)
    numbers = "0123456789"
    raise "wrong number of arguments" if position.split(" ").count != 2 
    raise "too many spaces" if !position.chars.one? { |c| c == " " }
    raise "position can have numbers only" if !position.split(" ").all? { |c| numbers.include?(c) } 
    true
  end
end