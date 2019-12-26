require_relative "player"

#
# 2-player game of Ghost with custom dictionaries
#
class Game
  attr_accessor :fragment
  def initialize(player_1, player_2)
    @fragment = ""
    dictionary_file = File.read("dictionary.txt").split("\n")
    @dictionary = Set.new(dictionary_file)
    @players = [Player.new(player_1), Player.new(player_2)]
    @current_player_idx = 0
    @losses = Hash.new
      @players.each { |player| @losses[player] = 0 }
  end

  def play_round
    puts "Start round:"
    loop do
      puts "Current Player: #{self.current_player.name}"
      break if take_turn(current_player)
      next_player!
    end
  end
  
  def run
    until @players.count == 1
      self.play_round
      
      puts record(self.current_player)
      if record(self.current_player) == "GHOST"
        puts "#{self.current_player.name} eliminated!"
        @players.delete_at(@current_player_idx)
      end

      # clean fragment, last game's winner starts
      @current_player_idx -= 1
      @fragment = ""
    end

    puts "@players.first.name Won!"
  end

  #
  # Return current user's loss score as part of "GHOST" word
  #
  # @param [Player] player Player object
  #
  # @return [String] Part of GHOST string based on loss count
  #
  def record(player)
    "GHOST"[0...@losses[player]]
  end

  def current_player
    @players[@current_player_idx]
  end

  def previous_player
    prev_player = (@current_player_idx - 1) % @players.count
    @players[prev_player]
  end

  def next_player!
    @current_player_idx = (@current_player_idx + 1) % @players.count
  end

  def take_turn(player)
    loop do
      puts "\nCurrent fragment: #{@fragment}"
      print "Enter next letter to the fragment: "
      input = gets.chomp
      if valid_play?(input)
        @fragment += input
        break
      end

      # round over? (no more words)
      if @dictionary.include?(@fragment + input)
        puts "#{@fragment + input} is a valid word!"
        puts "#{self.previous_player.name} won this round!"
        @losses[player] += 1
        return true
      end
    end
  end

  def valid_play?(string)
    alphabet = ("a".."z").to_a

    # Check if input is single letter
    if !alphabet.include?(string) || string.length != 1
      puts "wrong input"
      return false
    end
    
    # check if any more words are available
    new_fragment = @fragment + string
    if @dictionary.grep(/^#{new_fragment}./).empty?
      puts "No words with #{new_fragment} available in dictionary"
      return false
    end

    true
  end
end