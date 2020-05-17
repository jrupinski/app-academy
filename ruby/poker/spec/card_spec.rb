require "card"

describe Card do

  subject do
    Card.new(card_type)
  end

  describe "#value" do
    context "Two of Hearts" do
      let(:card_type) { "2H" }
      it { expect(:value).to eq 2 }
    end
    
    describe "Face Cards" do
      context "Jack of Clubs" do
        let(:card_type) { "JC" }
        it { expect(:value).to eq 11 }
      end

      context "Queen of Diamonds" do
        let(:card_type) { "QD" }
        it { expect(:value).to eq 12 }
      end

      context "King of Spades" do
        let(:card_type) { "KS" }
        it { expect(:value).to eq 13 }
      end
    end

    context "bad value" do
      let(:card_type) { "1S" }
      it { is_expected.to raise_error(ArgumentError) }
    end
  end
end
