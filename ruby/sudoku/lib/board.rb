require_relative "tile.rb"

class Board
  def initialize(grid)
    @grid = Board.from_file(grid)
  end

  def self.from_file(filename)
    file_data = File.read("../puzzles/#{filename}").split
    file_array = file_data.map(&:chars)
    file_array.map { |row| row.map { |value| Tile.new(value, false) } }
  end

  def render
    @grid.each { |row| row.each { |tile| print "#{tile.to_s} " }; puts }
    nil
  end
end