#
# Ver. 1: 3 x 3 grid
# Board class, creates a game board for Tic Tac Toe.
# Each player has different signs (X, O etc.), called a mark.
# 
# Example:
#   [:X :X "_"]
#   [:O :O "_"]
#   ["_" "_" :X]
# 
class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, "_") }
  end

  def place_mark(row, col, mark)
    if valid?(row, col) && empty?(row, col)
      @grid[row][col] = mark
      true
    else
      false
    end
  end

  def empty?(row, col)
    self.grid[row][col] == "_"
  end

  def valid?(row, col)
    (row >= 0 && row < @grid.length) && ( col >= 0 && col < @grid.transpose.length)
  end

  def game_over?
    vertical_streak? || horizontal_streak? || diagonal_streak? || self.grid.flatten.none? { |ele| ele == "_" }
  end

  def vertical_streak?
    self.grid.length.times do |col|
      curr_col = self.grid.transpose[col]
      return true if curr_col.uniq.count == 1 && !curr_col.uniq.include?("_")
    end
    
    false
  end

  def horizontal_streak?
    self.grid.length.times do |row|
      curr_row = self.grid.transpose[row]
      return true if curr_row.uniq.count == 1 && !curr_row.uniq.include?("_")
    end
    
    false
  end

  def diagonal_streak?
    diagonal_left = []
    diagonal_right = []

    (0...self.grid.length).each do |row|
      col = row
      right_diag_col = (self.grid.length - 1) - row
      diagonal_left << self.grid[row][col]
      diagonal_right << self.grid[row][right_diag_col]
    end

    (diagonal_left.uniq.count == 1 && !diagonal_left.uniq.include?("_")) || (diagonal_right.uniq.count == 1 && !diagonal_right.uniq.include?("_"))
  end

  def print_grid
    self.grid.length.times { |row| p self.grid[row] }
    nil
  end
end