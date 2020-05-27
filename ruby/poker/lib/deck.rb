require "card"

CARD_VALUES = [
  ("2".."10").to_a, "J", "Q", "K", "A"
].flatten.freeze

# :C => "clubs",
# :D => "diamonds",
# :H => "hearts",
# :S => "spades"
CARD_SUITES = [
  "C", "D", "H", "S"
].freeze

class Deck

  attr_reader :cards

  def initialize
    @cards = []
    
    CARD_VALUES.each do |value|
      CARD_SUITES.each do |suit|
        @cards << Card.new(value + suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end
end