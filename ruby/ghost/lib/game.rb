require_relative "player"

#
# 2-player game of Ghost with custom dictionaries
#
class Game
  def initialize(player_1, player_2)
    @fragment = ""
    dictionary_file = File.read("dictionary.txt").split("\n")
    @dictionary = Set.new(dictionary_file)
    @players = [Player.new(player_1), Player.new(player_2)]
    @current_player = 0
  end

  def play_round
    # TODO
  end

  def current_player
    @players[@current_player]
  end

  def previous_player
    prev_player = (@current_player - 1) % @players.count
    @players[prev_player]
  end

  def next_player!
    @current_player = (@current_player + 1) % @players.count
  end

  def take_turn(player)
    # TODO
  end

  def valid_play?
    # TODO
  end
end