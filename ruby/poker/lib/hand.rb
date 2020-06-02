require_relative "deck"
require "byebug"


class Hand
  attr_reader :cards

  def initialize()
    @cards = []
  end

  def draw!(deck)
    raise TypeError unless deck.is_a?(Deck)
    @cards << deck.draw!
  end

  def discard!(deck, card)
    raise TypeError unless card.is_a?(Card)
    deck.discard!(card)
    @cards.delete(card)
  end

  # Based on Wikipedia: https://en.wikipedia.org/wiki/List_of_poker_hands
  # going from best to worst: rank 0 -> rank 9
  def rank(cards)
    case
    when five_of_a_kind?(cards) then 0
    when straight_flush?(cards) then 1
    when four_of_a_kind?(cards) then 2
    when full_house?(cards) then 3
    when flush?(cards) then 4
    when straight?(cards) then 5
    when three_of_a_kind?(cards) then 6
    when two_pair?(cards) then 7
    when one_pair?(cards) then 8
    else 9 # high card
    end
  end

  def best_hand(hands)
    hand_ranking = hands.map { |hand| rank(hand) }
    best_hand_rank = hand_ranking.min

    possible_winners = []
    hand_ranking.each_with_index do |rank, player_idx|
      possible_winners << player_idx if rank == best_hand_rank 
    end

    return possible_winners.first if possible_winners.count == 1

    # TODO : fix draw scenarios and scenarios where >1 player has the same type of hand
    case best_hand_rank
    when 0
      possible_winners.reject! { |player| hands[player].first.min }
    when 1
      possible_winners.reject! { |player| hands[player].max }
    end

    :draw
  end


  private

  def same_suit?(cards)
    cards_suits = cards.map(&:suit)
    cards_suits.uniq.count == 1
  end
  

  def same_value?(cards)
    card_count(cards).values == [5]
  end

  def consecutive_ranks?(cards)
    cards_value = cards.map(&:value)
    cards_value.sort!
    cards_value.each_cons(2).all? {|a, b| b == a + 1 } 
  end

  #
  # Calculates how many of each card is in a Hand
  #
  # @param [Array] cards Cards Array
  #
  # @return [Hash] Key: rank number; Value: card count
  #
  def card_count(cards)
    card_counter = Hash.new(0)
    cards.map(&:value).each { |rank| card_counter[rank] += 1 }
    card_counter
  end


  # hand detection
  def five_of_a_kind?(cards)
    same_value?(cards)
  end

  def straight_flush?(cards)
    same_suit?(cards) && consecutive_ranks?(cards)
  end

  def four_of_a_kind?(cards)
    (card_count(cards).values - [4]) == [1]
  end

  def full_house?(cards)
    (card_count(cards).values - [3, 2]).empty?
  end

  def flush?(cards)
    same_suit?(cards)
  end

  def straight?(cards)
    consecutive_ranks?(cards)
  end

  def three_of_a_kind?(cards)
    (card_count(cards).values - [3]) == [1, 1]
  end

  def two_pair?(cards)
    (card_count(cards).values - [2, 2]) == [1]
  end

  def one_pair?(cards)
    (card_count(cards).values - [2]) == [1, 1, 1]
  end
end