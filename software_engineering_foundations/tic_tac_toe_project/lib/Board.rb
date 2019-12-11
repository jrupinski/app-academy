require "byebug"
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
      mark
    elsif !valid?(row, col)
      raise "invalid coordinates"
      false
    else
      raise "place already marked"
      false
    end
  end

  def empty?(row, col)
    self.grid[row][col] == "_"
  end

  def empty_positions?
    self.grid.flatten.any? { |ele| ele == "_" }
  end

  def valid?(row, col)
    (row >= 0 && row < @grid.length) && ( col >= 0 && col < @grid.transpose.length)
  end

  def win_col?(mark)
    if mark == "_"
      raise "symbol \"_\" is restricted"
      return false
    end

    self.grid.length.times do |col|
      curr_col = self.grid.transpose[col]
      return true if curr_col.uniq.include?(mark) && curr_col.uniq.count == 1
    end
    
    false
  end

  def win_row?(mark)
    if mark == "_"
      raise "symbol \"_\" is restricted"
      return false
    end

    self.grid.length.times do |row|
      curr_row = self.grid.transpose[row]
      return true if curr_row.uniq.include?(mark) && curr_row.uniq.count == 1
    end
    
    false
  end

  def win_diagonal?(mark)
    if mark == "_"
      raise "symbol \"_\" is restricted"
      return false
    end

    diagonal_left = []
    diagonal_right = []

    (0...self.grid.length).each do |row|
      col = row
      right_diag_col = (self.grid.length - 1) - row
      diagonal_left << self.grid[row][col]
      diagonal_right << self.grid[row][right_diag_col]
    end

    (diagonal_left.uniq.include?(mark) && diagonal_left.uniq.count == 1) || (diagonal_right.uniq.include?(mark) && diagonal_right.uniq.count == 1)
  end

  def print_grid
    self.grid.length.times { |row| p self.grid[row] }
    nil
  end
end