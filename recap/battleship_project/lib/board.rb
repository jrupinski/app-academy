require "byebug"

class Board
  attr_reader :size

  def initialize(size)
    @grid = Array.new(size) { Array.new(size, :N) }
    @size = size * size
  end

  def self.print_grid
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

  # PART 2
  def attack(position)
    if self[position] == :S
      self[position] = :H
      puts "You sunk my battleship!"
      true
    else
      self[position] = :X
      false
    end
  end

  def place_random_ships
    # ranom ships equals 25% of game board
    num_of_ships = self.size / 4

    # place n ships on empty gridspaces
    num_of_ships.times do 
      rand_position = [rand(@grid.length), rand(@grid.length)]
      until self[rand_position] == :N
        rand_position = [rand(@grid.length), rand(@grid.length)]
      end

      self[rand_position] = :S
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

  def self.print_grid(grid)
    grid.each { |row| puts row.join(" ") }
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end
