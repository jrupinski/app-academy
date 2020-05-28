require "hand"

describe Hand do
  let(:hand) { Hand.new }
  let(:card) { double(:value => "10", :suit => "H") }
  let(:deck) { double([card]) }


  it "starts with 5 cards" do
    expect(hand.cards.count).to eq(5)
  end

  it "allows to draw a card" do
    allow(deck).to receive(:draw).and_return(card)
    expect { hand.draw }.to_not raise_error
    expect(hand.cards.count).to eq(6)
  end

  it "allows to discard a card" do
    allow(deck).to receive(:discard).with(card)
    expect { hand.discard(card) }.to_not raise_error
    expect(hand.cards.count).to eq(5)
  end

  # Based on Wikipedia: https://en.wikipedia.org/wiki/List_of_poker_hands
  # going from best to worst: rank 0 -> rank 9
  # all cards's suit is a heart, unless stated otherwise
  describe "detects hand rank" do
    let(:ace) { double(value => "A", :suit => "H") }
    let(:king) { double(value => "K", :suit => "H") }
    let(:queen) { double(value => "Q", :suit => "H") }
    let(:jack) { double(value => "J", :suit => "H") }
    let(:ten_hearts) { double(:value => "10", :suit => "H") }
    let(:ten_clubs) { double(:value => "10", :suit => "C") }
    let(:four) { double(value => "4", :suit => "H") }

    context "five of a kind" do
      let(:hand) { [ace, ace, ace, ace, ace] }
      it { expect(hand.rank).to eq(0) }
    end

    context "straight flush" do
      let(:hand) { [ace, king, queen, jack, ten_hearts] }
      it { expect(hand.rank).to eq(1) }
    end

    context "four of a kind" do
      let(:hand) { [ace, ace, ace, jack, king] }
      it { expect(hand.rank).to eq(2) }
    end

    context "full house" do
      let(:hand) { [jack, jack, jack, king, king] }
      it { expect(hand.rank).to eq(3) }
    end

    context "flush" do
      let(:hand) { [ace, king, queen, jack, four] }
      it { expect(hand.rank).to eq(4) }
    end

    context "straight" do
      let(:hand) { [ace, king, queen, jack, ten_hearts] }
      it { expect(hand.rank).to eq(5) }
    end

    context "three of a kind" do
      let(:hand) { [ace, ace, ace, four, jack] }
      it { expect(hand.rank).to eq(6) }
    end

    context "two pair" do
      let(:hand) { [ace, ace, jack, jack, king] }
      it { expect(hand.rank).to eq(7) }
    end

    context "one pair" do
      let(:hand) { [ace, ace, four, jack, queen] }
      it { expect(hand.rank).to eq(8) }
    end

    context "high card" do
      let(:hand) { [ace, four, jack, king, ten_clubs] }
      it { expect(hand.rank).to eq(9) }
    end

    describe "detects winning hand" do
      let(:high_card) { [ace, four, jack, king, ten_clubs] }
      let(:one_pair) { [ace, ace, four, jack, queen] }
      let(:two_pair) { [ace, ace, jack, jack, king] }
      let(:straight) { [ace, king, queen, jack, ten_hearts] }
      let(:flush) { [ace, king, queen, jack, four] }

      let(:hands) { [flush, two_pair, one_pair, high_card, straight] }
      it { expect(hand.best_hand(hands)).to_eq[0] }
      let(:hands) { [one_pair, high_card, straight] }
      it { expect(hand.best_hand(hands)).to_eq(2) }
      let(:hands) { [one_pair, one_pair] }
      it { expect(hand.best_hand(hands)).to_eq(:draw) }
    end
  end
end