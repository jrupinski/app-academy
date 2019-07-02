def Game
  def initialize
    @dictionary = Set.new
    @players = Hash.new
    @fragment = ""
  end

  def self.current_player
    # TODO 
  end

  def self.previous_player
    # TODO
  end
  
  def self.next_player!
    # TODO
  end

  def self.take_turn(player)
    # TODO
  end

  def self.valid_play?(string)
    # TODO
  end
end