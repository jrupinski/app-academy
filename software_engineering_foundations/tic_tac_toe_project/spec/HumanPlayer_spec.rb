# Test suite for Tic Tac Toe ver. 1
require "HumanPlayer.rb"

describe "HumanPlayer" do
  # silence terminal output on rspec run
  before do
    allow($stdout).to receive(:write)
  end

  
  it "creates a new Player with his own mark_value" do
    expect { HumanPlayer.new(:X) }.to_not raise_error
    expect { HumanPlayer.new }.to raise_error(StandardError)
    expect(HumanPlayer.new(:X).mark_value).to eq(:X)
    expect(HumanPlayer.new(:Y).mark_value).to eq(:Y)
  end

  describe "get_position" do
    let (:player) { HumanPlayer.new(:Y) }

    it "gets board position from user (in form of 2 Integer numbers separated with space)" do
      allow(player).to receive(:gets).and_return("0 1")
      expect(player.get_position).to eq([0, 1])

      allow(player).to receive(:gets).and_return("5 5")
      expect(player.get_position).to eq([5, 5])

      allow(player).to receive(:gets).and_return("0  1")
      expect{ player.get_position }.to raise_error(HumanPlayer::TooManySpacesError)

      allow(player).to receive(:gets).and_return("1 2 3")
      expect{ player.get_position }.to raise_error(HumanPlayer::WrongNumOfArgumentsError)

      allow(player).to receive(:gets).and_return("1 2 3")
      expect{ player.get_position }.to raise_error(HumanPlayer::WrongNumOfArgumentsError)

      allow(player).to receive(:gets).and_return("1 ")
      expect{ player.get_position }.to raise_error(HumanPlayer::WrongNumOfArgumentsError)

      allow(player).to receive(:gets).and_return("a b")
      expect{ player.get_position }.to raise_error(HumanPlayer::PositionError)
    end
  end
end
