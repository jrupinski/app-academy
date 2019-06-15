class Board
  require "byebug"
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { Array.new(n, :N) } 
    @size = n * n
  end

  def self.print_grid(grid)
    grid.each { |row| puts row.join(" ") } 
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      puts "You sunk my battleship!"
      return true
    else
      self[position] = :X
      return false
    end
  end

  def place_random_ships
    ships_amount = self.size / 4

    while self.num_ships < ships_amount
      rand_row = rand(0...@grid.length)
      rand_col = rand(0...@grid.length)
      position = [ rand_row, rand_col ]
      self[position] = :S
    end
  end

  def hidden_ships_grid
    @grid.map do |row|
      row.map do |ele|
        if ele == :S
          :N
        else
          ele
        end
      end
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end

  def random_coordinate
    randomizer = Random.new
    limit = @grid.length
    randomizer.rand(limit)
  end

  def [](position)
    row, column = position
    @grid[row] [column]
  end

  def []=(position, value)
    row, column = position
    @grid[row] [column] = value
  end

  def num_ships
    @grid.flatten.count(:S)
  end
end
