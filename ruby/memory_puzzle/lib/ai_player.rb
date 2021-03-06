require "set"

class AiPlayer
  def initialize
    @known_cards = Hash.new { |hash, key| hash[key] = Array.new }
    @matched_cards = Set.new
    @first_card_guessed = false
  end

  def guess
    if @first_card_guessed
      second_guess
    else
      first_guess
    end
  end

  def receive_revealed_card(value, position)
    add_received_card(value, position)
  end
  
  def receive_match(card_1_position, card_2_position)
    add_matched_cards(card_1_position, card_2_position)
  end
  
  private

  def first_guess
    @first_card_guessed = true
    first_card_guess
  end

  def second_guess
    @first_card_guessed = false
    second_card_guess
  end
  
  def first_card_guess
      unless unmatched_pairs.empty?
        @first_card = guess_unmatched_card_position
      else
        @first_card = choose_random_unknown_card
      end
    end

  def second_card_guess
    unless first_card_pair.empty?
      first_card_pair
      .reject { |pos| pos == @first_card }
      .flatten
    else
      choose_random_unknown_card
    end
  end

  def guess_unmatched_card_position
    unless unmatched_pairs.empty?
      random_matched_pair = unmatched_pairs.values.sample
      random_matched_pair.sample
    end
  end

  def unmatched_pairs
    @known_cards.select { |cards, pos| pos.count > 1 }
  end

  def first_card_pair
    unmatched_pairs
      .select { |cards, positions| positions.include?(@first_card) }
      .values
      .flatten
      .each_slice(2)
      .to_a
  end

  def choose_random_unknown_card
    # based on board size 4
    all_positions = (0...4).to_a.repeated_permutation(2).to_a
    all_positions
      .reject do |pos|
        [*@matched_cards, *@known_cards, @first_card].include?(pos)
      end
      .sample
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
    @known_cards.delete_if { |k, v| v.include?(card_1_position || card_2_position) }
  end
end