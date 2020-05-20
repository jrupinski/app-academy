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

  def initialize(card)
    raise ArgumentError unless card.length.between?(2, 3) && card.is_a?(String)
    @card = card
  end

  def value
    value_str = @card[0...@card.length - 1].upcase
    VALUE_HASH[value_str] || (raise ArgumentError)
  end

  def suit
    valid_suits = "C D H S"
    suit = @card.chars.last
    raise ArgumentError unless valid_suits.include?(suit)
    suit.to_sym
  end
end