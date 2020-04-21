require_relative "board"
require_relative "human_player"
require_relative "display"

class Game
  attr_reader :board, :display, :players, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      black: HumanPlayer.new(:black, @display),
      white: HumanPlayer.new(:white, @display)
    }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      begin
        move = players[current_player].make_move
        board.move_piece(current_player, move.first, move.last)

        swap_turn!
        notify_players
      rescue => exception
        puts "#{exception.message}"
        sleep 1
        retry
      end
      
    end

    display.render
    puts "#{current_player}'s in a checkmate."
  end

  private

  def swap_turn!
    @current_player = (current_player == :white ? :black : :white) 
  end

  def notify_players
    puts "Check!" if board.in_check?(current_player)
  end
end


if $PROGRAM_NAME == __FILE__
  Game.new.play
end