#
# 2-player game of Ghost with custom dictionaries
#
class Game
  def initialize(player_1, player_2)
    @fragment = ""
    dictionary_file = File.read("dictionary.txt").split("\n")
    @dictionary = Set.new(dictionary_file)
    @players = [player_1, player_2]
  end

  def play_round
    # TODO
  end

  def current_player
    # TODO
  end

  def previous_player
    # TODO
  end

  def next_player!
    # TODO
  end

  def take_turn(player)
    # TODO
  end

  def valid_play?
    # TODO
  end
end