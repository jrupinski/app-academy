require "hand"

describe Hand do
  let(:hand) { Hand.new }
  let(:card) { double(:value => 10, :suit => "H") }
  let(:deck) { double(:cards => [card]) }

  # CARDS
    let(:ace) { double(:value => 14, :suit => "H") }
    let(:king) { double(:value => 13, :suit => "H") }
    let(:queen) { double(:value => 12, :suit => "H") }
    let(:jack) { double(:value => 11, :suit => "H") }
    let(:ten_hearts) { double(:value => 10, :suit => "H") }
    let(:ten_clubs) { double(:value => 10, :suit => "C") }
    let(:four) { double(:value => 4, :suit => "H") }
  
  
  it "starts with no cards" do
    expect(hand.cards).to eq([])
  end
  
  it "allows to draw a card" do
    allow(deck).to receive(:is_a?).with(Class) { true }
    allow(deck).to receive(:draw!).and_return(card)
    expect { hand.draw!(deck) }.to_not raise_error
    expect(hand.cards.count).to eq(1)
  end

  it "allows to discard a card" do
    allow(deck).to receive(:is_a?).with(Class) { true }
    allow(card).to receive(:is_a?).with(Class) { true }
    allow(deck).to receive(:draw!).and_return(card)
    allow(deck).to receive(:discard!).with(card)
    hand.draw!(deck)
    expect { hand.discard!(deck, card) }.to_not raise_error
    expect(hand.cards.count).to eq(0)
  end

  # Based on Wikipedia: https://en.wikipedia.org/wiki/List_of_poker_hands
  # going from best to worst: rank 0 -> rank 9
  # all cards's suit is a heart, unless stated otherwise
  describe "detects hand rank" do
    before(:each) { allow(hand).to receive(:cards).and_return(poker_hand) }

    context "five of a kind" do
      let(:poker_hand) { [ace, ace, ace, ace, ace] }
      it { expect(hand.rank(poker_hand)).to eq(0) }
    end

    context "straight flush" do
      let(:poker_hand) { [ace, king, queen, jack, ten_hearts] }
      it { expect(hand.rank(poker_hand)).to eq(1) }
    end

    context "four of a kind" do
      let(:poker_hand) { [ace, ace, ace, ace, king] }
      it { expect(hand.rank(poker_hand)).to eq(2) }
    end

    context "full house" do
      let(:poker_hand) { [jack, jack, jack, king, king] }
      it { expect(hand.rank(poker_hand)).to eq(3) }
    end

    context "flush" do
      let(:poker_hand) { [ace, king, queen, jack, four] }
      it { expect(hand.rank(poker_hand)).to eq(4) }
    end

    context "straight" do
      let(:poker_hand) { [ace, king, queen, jack, ten_clubs] }
      it { expect(hand.rank(poker_hand)).to eq(5) }
    end

    context "three of a kind" do
      let(:poker_hand) { [ace, ten_clubs, ten_clubs, ten_clubs, jack] }
      it { expect(hand.rank(poker_hand)).to eq(6) }
    end

    context "two pair" do
      let(:poker_hand) { [ace, ace, jack, ten_clubs, ten_clubs] }
      it { expect(hand.rank(poker_hand)).to eq(7) }
    end

    context "one pair" do
      let(:poker_hand) { [ace, ace, four, jack, ten_clubs] }
      it { expect(hand.rank(poker_hand)).to eq(8) }
    end

    context "high card" do
      let(:poker_hand) { [ace, four, jack, king, ten_clubs] }
      it { expect(hand.rank(poker_hand)).to eq(9) }
    end
  end

  describe "detects winning hand:" do
    # HANDS FOR TESTING
    let(:high_card) { [ace, four, jack, king, ten_clubs] }
    let(:one_pair) { [ace, ace, four, jack, ten_clubs] }
    let(:one_pair_lower_rank) { [ace, four, four, jack, ten_clubs] }
    let(:two_pair) { [ace, ace, jack, ten_clubs, ten_clubs] }
    let(:straight) { [ace, king, queen, jack, ten_clubs] }
    let(:flush) { [ace, king, queen, jack, four] }

    context "flush vs two pair vs one pair vs high card vs straight" do
      let(:hands) { [two_pair, one_pair, flush, high_card, straight] }
      it { expect(hand.best_hand(hands)).to eq([2]) }
    end

    context "flush vs two pair vs flush(again) one pair vs high card vs straight (2x identical flush - DRAW)" do
      let(:hands) { [flush, two_pair, one_pair, flush, high_card, straight] }
      it { expect(hand.best_hand(hands)).to eq([0, 3]) }
    end

    context "one pair vs high card vs straight" do
      let(:hands) { [one_pair, high_card, straight] }
      it { expect(hand.best_hand(hands)).to eq([2]) }
    end

    context "one pair vs one pair (same cards - DRAW)" do
      let(:hands) { [one_pair, one_pair] }
      it { expect(hand.best_hand(hands)).to eq([0, 1]) }
    end

    context "one pair vs one pair (with a lower ranked card)" do
      let(:hands) { [one_pair, one_pair_lower_rank] }
      it { expect(hand.best_hand(hands)).to eq([0]) }
    end
  end
end