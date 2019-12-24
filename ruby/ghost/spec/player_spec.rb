require "player"

describe Player do
  describe "::new" do
    it "creates a player with given name" do
      expect { Player.new("name") }.to_not raise_error 
      expect { Player.new }.to raise_error ArgumentError
      expect { Player.new(123) }.to raise_error Player::InvalidNameError

      expect(Player.new("name").name).to eq("name")
      expect(Player.new("").name).to eq("")
    end
  end

  describe "#guess" do
    let (:test_player) { Player.new("Player 1") }

    it "takes a 1-letter guess from the player" do
      allow(test_player).to receive(:gets).and_return("a")
      expect(test_player.guess).to eq(true)
      allow(test_player).to receive(:gets).and_return("B")
      expect(test_player.guess).to eq(true)
      allow(test_player).to receive(:gets).and_return("ab")
      expect(test_player.guess).to eq(false)
      allow(test_player).to receive(:gets).and_return("1")
      expect(test_player.guess).to eq(false)
      allow(test_player).to receive(:gets).and_return("%")
      expect(test_player.guess).to eq(false)
    end
  end
end