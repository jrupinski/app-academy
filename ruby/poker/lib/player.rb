require "deck"

class Player
  attr_reader :pot, :hand
  
  def initialize(pot)
    raise ArgumentError unless pot.is_a?(Integer)
    @pot = pot
    @hand = []
  end

  def draw!(card)
    raise TypeError unless card.is_a?(Card)
    raise MaxHandSizeError if hand.size >= 5
    hand << card
  end

  def discard!
    hand.delete_at(get_card_idx)
  end

  def fold
    :fold
  end

  def see
    :see
  end

  def raise_amount
    get_raise_amount
  end

  private

  def get_card_idx
    Integer(gets)
  end

  def get_raise_amount
    Integer(gets)
  end
end

class MaxHandSizeError < StandardError
  def initialize(msg="5 cards in hand limit reached")
    super
  end
end