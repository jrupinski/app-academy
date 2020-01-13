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
  
  def no_piece_diagonally?(row)
    board.each(&:one?)
  end

  def no_piece_vertically?(column)
    board.transpose.each(&:one?)
  end

  def no_piece_horizontally?
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