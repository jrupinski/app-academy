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
    row < @grid.length && col < @grid.transpose.length
  end

  def game_over?
    vertical_streak? || horizontal_streak? || diagonal_streak?
  end

  def vertical_streak?
    self.grid.length.times { |col| return true if self.grid.transpose[col].uniq.count == 1 }
    false
  end

  def horizontal_streak?
    self.grid.length.times { |row| return true if self.grid[row].uniq.count == 1}
    false
  end

  def diagonal_streak?
    diagonal_left = []
    diagonal_right = []

    self.grid.each_index do |ele, row|
      col = row
      right_diag_col = row - col
      diagonal_left << self.grid[row][col]
      diagonal_right << self.grid[row][right_diag_col]
    end

    diagonal_left.uniq.count == 1 || diagonal_right.uniq.count == 1
  end

  def print_grid
    self.grid.length.times { |row| p self.grid[row] }
  end
end