require_relative "board.rb"

class Game
  def initialize(size = 4)
    @board = Board.new(size)
    @previous_guess = nil
  end

  def play
    # todo
  end

  private

  def generate_board
    @board.populate
  end
end


if __FILE__ == $PROGRAM_NAME
  Game.new.play
end