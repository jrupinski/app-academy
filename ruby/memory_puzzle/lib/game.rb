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
      position = prompt_for_input
      make_guess(position)
    end
  end

  private

  def render_board
    @board.render
  end

  def generate_board
    @board.populate
  end

  def game_over
    @board.won?
  end

  def make_guess(position)
    current_card = reveal_card(position)
    if checking_another_card?
      unless @previous_guess == current_card
        [@previous_guess, current_card].each(&:hide)
      end
      
      @previous_guess = nil
    else
      @previous_guess = current_card
    end
  end

  def prompt_for_input
    print  "Enter row and col numbers, separated by a comma:"
    input = gets.chomp
    # convert string "n, n" to number array [n, n]
    input.split.map(&:to_i)
  end

  def reveal_card(position)
    @board.reveal(*position)
  end

  def checking_another_card?
    @previous_guess.nil? ? false : true
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end