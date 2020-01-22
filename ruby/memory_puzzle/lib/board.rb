require_relative "card.rb"

class Board
  def initialize(size)
    raise "Size error - wrong size for card pairs" if !size.even?
    @board = Array.new(size) { Array.new(size) }
  end

  def populate
    fill_board_with_card_pairs
  end

  def render
    print_current_board
  end
  
  def won?
    all_cards_revealed?
  end

  def reveal(row, col)
    raise "Coordinates out of bounds." if !in_grid?(row, col)
    reveal_card(row, col)
  end

  private

  def reveal_card(row, col)
    card = @board[row][col]
    if card.value.nil?
      card.reveal
      card.value
    end
  end

  def all_cards_revealed?
    @board.flatten.none? { |card| card.value.nil? }
  end

  def fill_board_with_card_pairs
    shuffled_cards = generate_card_pairs.shuffle
    
    (0...@board.size).each do |row|
      (0...@board.size).each do |col|
        @board[row][col] = shuffled_cards.pop
      end
    end
  end

  def generate_card_pairs
    shuffled_chars = ("A".."Z").to_a.shuffle
    generated_pairs = []
    number_of_pairs.times.each do |card_num|
      current_char = shuffled_chars[card_num]
      pair = 2.times.map { Card.new(current_char) }
      generated_pairs += pair
    end

    generated_pairs
  end

  def print_current_board
    # print column coordinates
    print "\t"
    (0...@board.length).each { |col| print "#{col}\t"}
    puts
    
    @board.each_with_index do |row, row_idx|
      # print row coordinates
      print "#{row_idx}\t"

      row.each.with_index do |card|
        if card.nil? || card.value.nil?
          print " \t"
        else
          print "#{card}\t"
        end 
      end

      puts
    end
  end

  def in_grid?(row, col)
    (row <= @board.length && col <= @board.length) && (row >= 0 && col >= 0)
  end

  def number_of_cards
    @board.flatten.count
  end

  def number_of_pairs
    number_of_cards / 2
  end
end