class AiPlayer
  def initialize
    @known_cards = Hash.new { |hash, key| hash[key] = Array.new }
  end

  def receive_revealed_card(value, position)
    @known_cards[value] << position unless @known_cards[value].include?(position)
  end

end