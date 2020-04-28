require_relative "board"
require_relative "players"
require_relative "display"

class Game
  attr_reader :board, :display, :players, :current_player

  def initialize(debug = false)
    @board = Board.new
    @display = Display.new(@board, debug)
    @players = {
      black: HumanPlayer.new(:black, @display),
      white: AiPlayer.new(:white, @display)
    }
    @current_player = :white
  end

  #
  # Play a game of Chess in terminal
  #
  # @return [nil] Print out game over
  #
  def play
    until board.checkmate?(current_player)
      begin
        ai_playing = players[current_player].is_a?(AiPlayer)
        
        move = players[current_player].make_move
        board.move_piece(current_player, move.first, move.last, ai_playing)

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
    puts "#{current_player} in check!" if board.in_check?(current_player)
  end
end


if $PROGRAM_NAME == __FILE__
  ARGV[0] == "debug" ? Game.new(true).play : Game.new.play
end