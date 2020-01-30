require_relative "tile.rb"
require "byebug"
class Board
  attr_reader :grid

  def initialize(grid)
    @grid = Board.from_file(grid)
  end

  def self.from_file(filename)
    file_data = File.read("../puzzles/#{filename}").split
    file_array = file_data.map(&:chars)
    file_array_to_tile_grid(file_array)
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
  
  # private

  def self.file_array_to_tile_grid(file_array)
    file_array.map do |row|
      row.map do |value|
        value.to_i > 0 ? Tile.new(value, false) : Tile.new(value)
      end
    end
  end

  def all_rows_solved?
    grid.all? { |row| row_solved?(row) }
  end

  def row_solved?(row)
    (1..9).all? do |num|
      row.one? { |tile| tile.value == num }
    end
  end

  def all_columns_solved?
    grid.transpose.all? { |column| row_solved?(column) }
  end

  def all_squares_solved?
    squares = divide_grid_into_squares
    squares.all? { |square| square_solved?(square) }
  end

  def square_solved?(square)
    row_solved?(square.flatten)
  end

  def divide_grid_into_squares
    num_of_square_columns = grid.length / 3
    sliced_grid = divide_rows_into_threes
    squares = []

    # create squares for each "column" of squares (column = three tiles)
    (0...num_of_square_columns).each do |column_num|
      (column_num...sliced_grid.length).step(3) do |idx|
        squares << sliced_grid[idx]
      end
    end

    # slice each column into squares of 3 height(3x3)
    squares.each_slice(3)
  end


  # helper methods

  def divide_rows_into_threes
    threes = []
    grid.each { |row| threes += row.each_slice(3).to_a }
    threes
  end

  def render_squares
    divide_grid_into_squares.each do |square|
      square.each { |row| row.each { |tile| print "#{tile.to_s} " }; puts }
      puts
    end

    nil
  end
end