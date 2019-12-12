#
# Tic Tac Toe game, ver. 1
# Basic 3x3 grid game with 2 human players
#
require_relative "./Board.rb"
require_relative "./HumanPlayer.rb"

class Game
  def initialize(player_1_mark, player_2_mark)
    @player_1_mark = HumanPlayer.new(player_1_mark)
    @player_2_mark = HumanPlayer.new(player_2_mark)
    @players = [@player_1_mark, @player_2_mark]
    @board = Board.new
  end

  def play
    while @board.empty_positions?

      @players.each do |player|
        @board.place_mark(*get_position(player), player.mark_value)
        @board.print_grid
        return "GAME OVER" if win?(player) || tie?
      end

    end
  end

  def tie?
    if !@board.empty_positions?
      puts "TIE"
      return true
    end

    false
  end

  def win?(player)
    mark = player.mark_value
    if @board.win_col?(mark) || @board.win_row?(mark) || @board.win_diagonal?(mark)
      puts "#{mark} WON!"
      return true 
    end

    false
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