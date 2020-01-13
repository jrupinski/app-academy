require "set"

#
# Find positions of eight queens on 8x8 grid where they don't attack each other
#
class EightQueens
  def initialize
    @board = Array.new(8) { Array.new(8, false) }
  end
  
  def find_position
    # TODO
  end
  
  def cannot_be_attacked?(position_row, position_column)
    no_attacks_vertically(position_row, position_column)
    no_attacks_horizontally(position_row, position_column)
    no_attacks_diagonally(position_row, position_column)
  end

  def no_attacks_horizontally?
    a.board.none? { |row| row.count(true) > 1 }
  end

  def no_attacks_vertically?
    a.board.transpose.none? { |column| column.count(true) > 1 }
  end

  # TODO: Check EVERY diagonal
  def no_attacks_diagonally?(row)
    diagonal_left = []
    (0...board.length).each do |row|
      column = row
      diagonal_left << board[row][column]
      diagonal_right << board[row].reverse[column]
    end
  end

  # private
  attr_reader :board
end
  
if $PROGRAM_NAME == __FILE__
  EightQueens.new.find_position
end