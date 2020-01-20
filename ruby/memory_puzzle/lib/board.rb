require_relative "card.rb"

class Board
  def initialize(size)
    @board = Array.new(size) { Array.new(size) }
  end

  def populate
    fill_board_with(pairs_of_characters)
  end

  def render
    print_current_board
  end
  
  def won?
    all_cards_revealed?
  end

  def reveal(guessed_position)
    reveal_card(guessed_position)
  end

  # TODO - implement private methods
  private

  def fill_board_with(characters)
    # TODO
  end

  def pairs_of_characters
    # TODO
  end

  def print_current_board
    # TODO
  end

  def reveal_card(position)
    # TODO
  end

  def all_cards_revealed?
    # TODO
  end

end