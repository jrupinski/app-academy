require "byebug"
class Card

  VALUE_HASH = {
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13
  }

  SUITS_HASH = { 
    :C => "clubs",
    :D => "diamonds",
    :H => "hearts",
    :S => "spades"
  }

  attr_reader :suit

  def initialize(card)
    raise ArgumentError unless card.length.between?(2, 3) && card.is_a?(String)
    @value = card[0...card.length - 1].upcase
    @suit = card[-1].upcase.to_sym
    raise ArgumentError unless valid_suit? && valid_value?
  end
  
  def value
    VALUE_HASH[@value]
  end

  def valid_value?
    VALUE_HASH.has_key?(@value)
  end

  def valid_suit?
    SUITS_HASH.has_key?(@suit)
  end
end