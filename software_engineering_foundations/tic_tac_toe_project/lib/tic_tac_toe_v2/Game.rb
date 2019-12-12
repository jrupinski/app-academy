#
# Tic Tac Toe game, ver. 1
# NxN grid game with at least 2 human players
#
require_relative "./Board.rb"
require_relative "./HumanPlayer.rb"

class Game
  def initialize(square_grid_size, *players_mark)
    raise "2+ players required" if players_mark.count < 2
    raise "3x3 grid minimum" if square_grid_size < 3

    @board = Board.new(square_grid_size)
    @players = []
    players_mark.each { |mark| @players << HumanPlayer.new(mark) }
    @current_player_idx = 0
    @current_player = @players[@current_player_idx]
  end

  def switch_turn
    num_of_players = @players.count
    @current_player = @players[(@current_player_idx += 1) % num_of_players]
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