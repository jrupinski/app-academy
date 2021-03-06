require_relative "tile.rb"

class Board
  attr_reader :grid

  # generate board from a text file
  def self.from_file(filename)
    rows = File.readlines("../puzzles/#{filename}").map(&:chomp)
    tiles = rows.map do |row|
      nums = row.chars.map { |char| Integer(char) }
      nums.map { |num| Tile.new(num) }
    end

    self.new(tiles)
  end

  def initialize(grid)
    @grid = grid
  end

  def render
    grid.each { |row| row.each { |tile| print "#{tile.to_s} " }; puts }
    nil
  end

  def solved?
    all_rows_solved?
    all_columns_solved?
    all_squares_solved?
  end

  def [](position)
    row, col = position
    grid[row][col]
  end

  def []=(position, value)
    row, col = position
    tile = grid[row][col]
    tile.value = value
  end

  private

  def all_rows_solved?
    grid.all? { |row| row_solved?(row) }
  end


  def all_columns_solved?
    grid.transpose.all? { |column| row_solved?(column) }
  end

  def all_squares_solved?
    squares = divide_grid_into_squares
    squares.all? { |square| square_solved?(square) }
  end

  # helper methods

  def row_solved?(row)
    (1..9).all? do |num|
      row.one? { |tile| tile.value == num }
    end
  end
  
  # square is a 3x3 tile
  def square_solved?(square)
    row_solved?(square.flatten)
  end

  def divide_grid_into_squares
    squares = []

    square_column_indexes.each do |column_num|
      squares += create_squares_from_column(column_num)
    end

    squares
  end

  def square_column_indexes
    square_column_indexes = (0...grid.length).step(3).to_a
  end

  def create_squares_from_column(square_column_idx)
    grid.map do |row| 
        square_start = square_column_idx
        square_end = square_start + 3
        row[square_start...square_end]
    end
    .each_slice(3).to_a
  end
end