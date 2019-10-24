class Board
  attr_reader :size

  def initialize(size)
    @grid = Array.new(size) { Array.new(size, :N) }
    @size = size * size
  end

  def print_grid
    @grid.length.times { |sub_grid| p @grid[sub_grid] }
  end

  def [](position)
    @grid[position.first][position.last]
  end

  def []=(position, value)
    @grid[position.first][position.last] = value
  end

  def num_ships
    count = 0
    @grid.each { |row| row.each { |ele| count += 1 if ele == :S } }
    count
  end

end
