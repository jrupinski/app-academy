class AiPlayer
  def initialize
    @known_cards = Hash.new { |hash, key| hash[key] = Array.new }
    @matched_cards = Set.new
  end

  def guess
    # TODO: Add second card guess
    first_card = first_card_guess
  end

  def receive_revealed_card(value, position)
    add_received_card(value, position)
  end

  def receive_match(card_1_position, card_2_position)
    add_matched_cards(card_1_position, card_2_position)
  end

  private

  def first_card_guess
    unless unmatched_pairs.empty?
      guess_unmatched_card
    else
      choose_random_unknown_card
    end
  end

  def guess_unmatched_card_position
    random_matched_pair = unmatched_pairs.values.sample
    random_matched_pair.sample
  end

  def unmatched_pairs
    @known_cards.select { |cards, pos| pos.count > 1 }
  end

  def choose_random_unknown_card
    # based on board size 4
    all_positions = (0...4).to_a.repeated_permutation(2).to_a
    all_positions.reject { |pos| @matched_cards.include?(pos) }.sample
  end

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