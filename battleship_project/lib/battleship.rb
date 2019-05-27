require_relative "board"
require_relative "player"


class Battleship
  attr_reader :player, :board


  def initialize(size)
    @player = Player.new
    @board = Board.new(size)
    @remaining_misses = self.board.size / 2
  end

  def start_game
    self.board.place_random_ships
    puts "#{self.board.size / 4} ships placed on board."
    self.board.print
  end

  def lose?
    if @remaining_misses <= 0
      puts "You lose"
      return true
    end

    false
  end

  def win?
    if self.board.num_ships <= 0
      puts "You win"
      return true
    end

    false
  end

  def game_over?
    return true if self.lose? || self.win?

    false
  end

  def turn
    input = self.player.get_move
    @remaining_misses -= 1 if !self.board.attack(input)
    self.board.print
    puts "You have #{@remaining_misses} misses left"
  end
end
