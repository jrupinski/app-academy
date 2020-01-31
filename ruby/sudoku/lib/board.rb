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
    # file_array_to_tile_grid(file_array)
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
    squares = []

    square_column_indexes.each do |column_num|
      squares += create_squares_from_column(column_num)
    end

    squares
  end


  # helper methods
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

  def grid_square_width
    grid.length / 3
  end

  def render_squares
    divide_grid_into_squares.each do |square|
      square.each { |row| row.each { |tile| print "#{tile.to_s} " }; puts }
      puts
    end

    nil
  end
end