require "card"

describe Card do

  subject do
    Card.new(card_type)
  end

  describe "#value" do
    context "Two of Hearts" do
      let(:card_type) { "2H" }
      it { expect(subject.value).to eq 2 }
    end

    context "Ten of Spades" do
      let(:card_type) { "10S" }
      it { expect(subject.value).to eq 10 }
    end

    describe "Face Cards" do
      context "Jack of Clubs" do
        let(:card_type) { "JC" }
        it { expect(subject.value).to eq 11 }
      end

      context "Queen of Diamonds" do
        let(:card_type) { "QD" }
        it { expect(subject.value).to eq 12 }
      end

      context "King of Spades" do
        let(:card_type) { "KS" }
        it { expect(subject.value).to eq 13 }
      end

      context "Ace of Spades" do
        let(:card_type) { "AS" }
        it { expect(subject.value).to eq 14 }
      end
    end

    context "Bad value" do
      context "Bad string:" do
        let(:card_type) { "1S" }
        it { expect { subject.value }.to raise_error(ArgumentError) }
      end

      context "Array:" do
        let(:card_type) { [10] }
        it { expect { subject.value }.to raise_error(ArgumentError) }
      end

      context "Empty string:" do
        let(:card_type) { "" }
        it { expect { subject.value }.to raise_error(ArgumentError) }
      end
    end
  end

  describe "#suit" do
    context "Two of Hearts" do
      let(:card_type) { "2H" }
      it { expect(subject.suit).to eq "hearts" }
    end

    context "Ten of Spades" do
      let(:card_type) { "10S" }
      it { expect(subject.suit).to eq "spades" }
    end

    describe "Face Cards" do
      context "Jack of Clubs" do
        let(:card_type) { "JC" }
        it { expect(subject.suit).to eq "clubs" }
      end

      context "Queen of Diamonds" do
        let(:card_type) { "QD" }
        it { expect(subject.suit).to eq "diamonds" }
      end

      context "King of Spades" do
        let(:card_type) { "KS" }
        it { expect(subject.suit).to eq "spades" }
      end
    end

    context "Bad suit" do
      context "Bad string:" do
        let(:card_type) { "2X" }
        it { expect { subject.suit }.to raise_error(ArgumentError) }
        
        let(:card_type) { "Q5" }
        it { expect { subject.suit }.to raise_error(ArgumentError) }
      end

      context "Empty string:" do
        let(:card_type) { "" }
        it { expect { subject.suit }.to raise_error(ArgumentError) }
      end
    end
  end
end
