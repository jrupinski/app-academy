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
end
