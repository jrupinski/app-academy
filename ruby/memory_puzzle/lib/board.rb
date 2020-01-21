require_relative "card.rb"

class Board
  def initialize(size)
    @board = Array.new(size) { Array.new(size) }
  end

  def populate
    fill_board_with_cards
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
  # private

  def fill_board_with_cards
    # TODO
  end

  def generate_card_pairs
    shuffled_chars = ("A".."Z").to_a.shuffle
    generated_pairs = []
    number_of_cards.times.each do |card_num|
      current_char = shuffled_chars[card_num]
      pair = 2.times.map { Card.new(current_char) }
      generated_pairs += pair
    end

    generated_pairs
  end

  def number_of_cards
    @board.flatten.count
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