require "byebug"
#
# Player class for Tic Tac Toe game
#
class HumanPlayer
  attr_reader :mark_value

  # Exception classes
  class WrongNumOfArgumentsError < StandardError; end
  class TooManySpacesError < StandardError; end
  class PositionError < StandardError
    def message
      "position can have numbers only"
    end
  end

  def initialize(mark_value)
    @mark_value = mark_value
  end

  def get_position
    p "current mark: #{self.mark_value}"
    print "Enter row and column (separated with space): "
    position = gets.chomp
    
    valid_format?(position)

    row = position.split(" ").first.to_i
    col = position.split(" ").last.to_i
    [row, col]
  end

  def valid_format?(position)
    numbers = "0123456789"
    raise WrongNumOfArgumentsError if position.split(" ").count != 2 
    raise TooManySpacesError if !position.chars.select { |c| c == " " }.one?
    raise PositionError if !position.split(" ").all? { |c| numbers.include?(c) } 
    true
  end

end