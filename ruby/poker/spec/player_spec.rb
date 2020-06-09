require "player"

describe "Player" do
  subject(:player) { Player.new(1000) }
  
  # CARDS
  let(:four) { double(:value => 4, :suit => "hearts") }
  let(:five) { double(:value => 5, :suit => "clubs") }
  # deck
  let(:deck) { double(:cards => [four, five, four, five, four, five]) }

  before(:each) do
    allow(deck).to receive(:draw!).and_return(deck.cards.pop)
    allow(deck).to receive(:array).and_return(deck.cards)
    allow(deck).to receive(:is_a?).with(Class) { true }
    allow(four).to receive(:is_a?).with(Class) { true }
    allow(five).to receive(:is_a?).with(Class) { true }
  end


  context "Player's hand" do
    it "starts with empty hand" do
      expect(player.hand).to be_empty
    end

    it "holds 5 cards max" do
      allow(player).to receive(:hand).and_return([five, four, five, four])

      expect(player.hand.size).to eq(4)
      player.draw!(five)
      expect(player.hand.size).to eq(5)
      
      expect { player.draw! }.to raise_error(ArgumentError)
      expect { player.draw!("bad data") }.to raise_error(TypeError)
      expect { player.draw!(deck.draw!) }.to raise_error(MaxHandSizeError)
    end
  end

  it "Has a pot" do
    expect(player.pot).to be_kind_of(Integer)
    expect { Player.new("test") }.to raise_error(ArgumentError)
  end

  context "Gameplay methods" do
    before(:each) do
        allow(player).to receive(:hand).and_return([five, four, five, four, five])
    end

    it "Allows the player to select cards to discard" do
      allow(player).to receive(:gets).and_return(0)

      expect(player.hand.size).to eq(5)
      expect(player.discard!).to eq(five)
      expect(player.hand.size).to eq(4)
    end

    it "Allows the player to fold" do
      expect(player.fold).to eq(:fold)
    end

    it "Allows the player to see" do
      expect(player.see).to eq(:see)
    end

    it "Allows the player to raise" do
      allow(player).to receive(:gets).and_return 100
      expect(player.raise_amount).to eq(100)
      allow(player).to receive(:gets).and_return "bad_data"
      expect { player.raise_amount }.to raise_error(ArgumentError)
    end
  end
end
