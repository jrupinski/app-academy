class AiPlayer
  def initialize
    @known_cards = Hash.new { |hash, key| hash[key] = Array.new }
    @matched_cards = Set.new
  end

  def receive_revealed_card(value, position)
    add_received_card(value, position)
  end

  def receive_match(card_1_position, card_2_position)
    add_matched_cards(card_1_position, card_2_position)
  end

  private

  def add_received_card(value, position)
    unless @known_cards[value].include?(position)
      @known_cards[value] << position 
    end
  end

  def add_matched_cards(card_1_position, card_2_position)
    @matched_cards.add(card_1_position)
    @matched_cards.add(card_2_position)
    remove_from_known_cards(card_1_position, card_2_position)
  end

  def remove_from_known_cards(card_1_position, card_2_position)
    @known_cards.delete_if { |k, v| v == card_1_position || card_2_position }
  end
end