require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player

  def initialize(size)
    @player = Player.new
    @board = Board.new(size)
    @remaining_misses = @board.size / 2
  end

  def start_game
    @board.place_random_ships
    puts @board.num_ships
    @board.print
  end

  def lose?
    if @remaining_misses <= 0
      puts "you lose"
      return true
    else
      false
    end
  end

  def win?
    if board.num_ships <= 0
      puts "You win!"
      return true
    else
      false
    end
  end

  def game_over?
    return true if self.win? || self.lose?
    false
  end

  def turn
    coordinates = player.get_move
    @remaining_misses -= 1 if !board.attack(coordinates)
    puts board.print
    puts @remaining_misses
  end
end
