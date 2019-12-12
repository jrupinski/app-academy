#
# Tic Tac Toe game, ver. 1
# Basic 3x3 grid game with 2 human players
#
require_relative "./Board.rb"
require_relative "./HumanPlayer.rb"

class Game
  class RestrictedSymbolError < StandardError
    def message
      "\"_\" symbol is restricted, please use another"
    end
  end

  def initialize(player_1_mark, player_2_mark)
    raise RestrictedSymbolError if player_1_mark == "_" || player_2_mark == "_"
    
    @board = Board.new
    @player_1 = HumanPlayer.new(player_1_mark)
    @player_2 = HumanPlayer.new(player_2_mark)
    @current_player = @player_1
  end

  def switch_turn
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def play
    while @board.empty_positions?
      @board.print_grid
      place_player_mark(@current_player)
      return "VICTORY! #{@current_player.mark_value} WON!" if win?(@current_player)
      switch_turn
    end

    puts "TIE"
  end

  def place_player_mark(player)
    # keep looping until position input is in board's borders
    loop do
      begin
        position = get_position(@current_player)
        mark = @current_player.mark_value
        @board.place_mark(*position, mark)
      rescue => exception
        puts exception.message
      else
        return
      end
    end
  end

  def win?(player)
    mark = player.mark_value
    @board.win_col?(mark) || @board.win_row?(mark) || @board.win_diagonal?(mark)
  end

  def get_position(player)
    # keep looping until position input is correct
    loop do

      begin
        position = player.get_position
      rescue => exception
        puts exception.message
      else
        return position
      end

    end
  end
end