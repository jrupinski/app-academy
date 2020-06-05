require "deck"

describe Deck do
  subject(:deck) { Deck.new }

  it "contains 52 cards" do
    expect(deck.cards.count).to eq(52)
    deck.cards.all? do |card|
      expect(card).to be_an_instance_of(Card)
    end
  end

  it "contains no duplicates" do
    deck.cards.uniq!(&:name)
    expect(deck.cards.count).to eq(52)
  end
  
  describe "has 13 cards of each suit" do
    before(:each) { deck.cards.select! { |card| card.suit == card_suit} } 
    
    context "clubs" do
      let(:card_suit) { "clubs" }
      it "has 13 unique cards" do
        expect(deck.cards.count).to eq(13)
      end
    end

    context "hearts" do
      let(:card_suit) { "hearts" }
      it "has 13 unique cards" do
        expect(deck.cards.count).to eq(13)
      end
    end

    context "diamonds" do
      let(:card_suit) { "diamonds" }
      it "has 13 unique cards" do
        expect(deck.cards.count).to eq(13)
      end
    end

    context "spades" do
      let(:card_suit) { "spades" }
      it "has 13 unique cards" do
        expect(deck.cards.count).to eq(13)
      end
    end
  end

  it "allows to shuffle the deck" do
    unshuffled_deck = deck.cards.dup
    expect { deck.shuffle }.to_not raise_error
    expect(unshuffled_deck).to_not eq(deck.cards)

    deck.cards.sort! { |x, y| x.name <=> y.name }
    unshuffled_deck.sort! { |x, y| x.name <=> y.name }
    expect(unshuffled_deck).to eq(deck.cards)
  end

  it "allows to draw a card" do
    expect(deck.draw!).to be_a(Card)
    expect(deck.cards.count).to eq(51)
  end

  it "allows to discard cards" do
    card = Card.new("KS") 
    expect { deck.discard!(card) }.to_not raise_error
    expect(deck.cards.count).to eq(53)
  end
end