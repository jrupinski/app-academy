class AiPlayer
  def initialize
    @known_cards = Hash.new { |hash, key| hash[key] = Array.new }
    @matched_cards = Set.new
  end

  def receive_revealed_card(value, position)
    @known_cards[value] << position unless @known_cards[value].include?(position)
  end

  def receive_match(card_1_position, card_2_position)
    @matched_cards.add(card_1_position)
    @matched_cards.add(card_2_position)
  end
end