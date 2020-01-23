require_relative "board.rb"

class Game
  def initialize(size = 4)
    @board = Board.new(size)
    @previous_guess = nil
  end

  def play
    generate_board
    until game_over
      render_board
      check_pair_of_cards
    end
  end

  private

  def render_board
    @board.render
  end

  def check_pair_of_cards
    # TODO
  end

  def generate_board
    @board.populate
  end

  def game_over
    @board.win?
  end

  def reveal_card
    row, col = get_user_coordinates
    @previous_guess = @board.reveal(row, col)
  end

  def get_user_coordinates
    print  "Enter row and col numbers, separated by a comma:"
    input = gets.chomp
    # convert string "n, n" to number array [n, n]
    input.split.map(&:to_i)
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end