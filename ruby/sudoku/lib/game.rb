require_relative "board.rb"

class Game
  def initialize(filename)
    @board = Board.new(filename)
  end

  def play
    until board.solved?
      board.render
      position = get_positon
      value = get_value
    end
  end

  def get_positon
    print "Enter row and column position, separated by a comma:> "
    loop do
      pos = parse_position(user_input)
      return pos if valid_position?(pos)
      print "Position invalid or out of bounds. Retry:> "
    end
  end

  def get_value
    print "Enter value:> "
    loop do
      value = parse_value(user_input)
      return value if valid_value?(value)
      print "Invalid value (values between 1 and 9 only). Retry:> "
    end
  end

  def valid_position?(position)
    position.count == 2 && position.all? { |value| value >= 0 && value < board.size }
  end

  def valid_value?(value)
    value > 0 && value < 10
  end

  def parse_position(input)
    input.split(",").map(&:to_i)
  end

  def parse_value(input)
    input.to_i
  end

  def user_input
    gets.chomp
  end

  def board
    @board.grid
  end
end