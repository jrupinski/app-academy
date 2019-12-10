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
    p "Enter row and column (separated with space): "
    position = gets.chomp
    
    valid_format?(position)

    row = position.split(" ").first
    col = position.split(" ").last
    [row, col]
  end

  def valid_format?(position)
    numbers = "0123456789"
    raise "too many spaces" if !position.chars.one? { |c| c == " " }
    raise "wrong number of arguments" if position.split(" ").count != 2 
    raise "position can have numbers only" if !position.split(" ").all? { |c| numbers.include?(c) } 
    true
  end
end