require "set"

#
# Find positions of eight queens on 8x8 grid where they don't attack each other
#
class EightQueens
  def initialize
    @board = Array.new(8) { Array.new(8, false) }
  end

  private 
  
  def queens_positions
    positions = []
    @board.each.with_index do |line, row|
      line.each.with_index { |position, col| positions << [row, col] if position == true }
    end
    positions
  end
  
  def no_conflicts?
    no_conflicts_vertically? && no_conflicts_horizontally? && no_conflicts_diagonally?
  end
  
  def no_conflicts_horizontally?
    @board.none? { |row| row.count(true) > 1 }
  end
  
  def no_conflicts_vertically?
    @board.transpose.none? { |column| column.count(true) > 1 }
  end
  
  def no_conflicts_diagonally?
    queens_positions.each_slice(2).none? do |queen_1, queen_2|
      queen_1_row, queen_1_col = queen_1.first, queen_1.last
      queen_2_row, queen_2_col = queen_2.first, queen_2.last
      delta_row = (queen_1_row - queen_2_row).abs
      delta_column = (queen_1_col - queen_2_col).abs
      delta_column == delta_row
    end
  end
end

if $PROGRAM_NAME == __FILE__
  # TODO
end