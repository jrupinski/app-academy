require_relative "board.rb"

class Game
  attr_reader :board

  def initialize(grid_size)
    @board = Board.new(grid_size)
  end

  def play
    until board.solved?
      board.render
      prompt
      board.set_value(get_user_input)
    end
  end
end