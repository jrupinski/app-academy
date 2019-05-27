class Board
  require "byebug"
  attr_reader :size

  def initialize(n)
    @grid = []
    n.times { @grid << Array.new(n, :N) } 
    @size = n * n
  end

  def self.print_grid(grid)
    grid.each { |row| puts row.join(" ") } 
  end

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
    ships_amount = self.size / 4

    ships_amount.times do
      x = 0, y = 0
      
      # don't place two S's in same place
      loop do
        x = random_coordinate
        y = random_coordinate
        break if @grid[x][y] != :S
      end
      # # don't place two S's in same place
      # while @grid[x][y] == :S        
      #   x = random_coordinate
      #   y = random_coordinate
      # end

      # place ship
      @grid[x][y] = :S
    end
  end

  def hidden_ships_grid
    # debugger
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
    @grid[position[0]] [position[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]] = value
  end

  def num_ships
    @grid.flatten.count(:S)
  end
end
