require_relative "tile.rb"

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
    @grid.each { |row| row.each { |tile| print "#{tile.to_s} " }; puts }
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
end