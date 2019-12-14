#
# Tic Tac Toe game, ver. 3
# NxN grid game with at least 2 AI or human players
#
require_relative "./Board.rb"
require_relative "./HumanPlayer.rb"
require_relative "./ComputerPlayer.rb"

class Game
  class RestrictedSymbolError < StandardError
    def message
      "Symbols only. \"_\" symbol is restricted, please use another"
    end
  end

  def initialize(board_size, players_hash)
    players = players_hash.values
    marks = players_hash.keys
    raise "2+ players required" if players.count < 2
    raise RestrictedSymbolError if marks.any? { |mark| mark == "_" || !mark.is_a?(Symbol) }
    raise "Players can't use the same symbol" if marks.count != marks.uniq.count
    raise "3x3 grid minimum" if board_size < 3
    
    @board = Board.new(board_size)
    @players = []

    # check if players are supposed to be AI or human 
    players_hash.each do |mark, player_type|
      player_type == "human" ? @players << HumanPlayer.new(mark) : @players << ComputerPlayer.new(mark)
    end

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
      puts
      place_player_mark(@current_player)

      if win?(@current_player)
        puts "VICTORY! #{@current_player.mark_value} WON!" 
        return nil
      end
      
      switch_turn
    end

    @board.print_grid
    puts "TIE"
    nil
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
        if player.instance_of?(HumanPlayer)
          position = player.get_position
        else
          position = player.get_position(@board.legal_positions)
        end
      rescue => exception
        puts exception.message
      else
        return position
      end

    end
  end
end