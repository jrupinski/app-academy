require_relative "board.rb"

class Game
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def play
    play_turn until board.solved?
    game_over
  end

  private

  def play_turn
    board.render
    position = get_positon
    value = get_value
    board[position] = value
    pause
    clear_terminal
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

  def game_over
    board.render
    puts "\nSudoku solved!"
  end
  
  # helper methods

  attr_reader :board

  def pause
    sleep 2 unless board.solved?
  end
  
  def clear_terminal
    system 'clear'
  end

  def grid
    @board.grid
  end

  def user_input
    gets.chomp
  end

  def valid_position?(position)
    position.count == 2 && position.all? { |value| value >= 0 && value < grid.size }
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
end