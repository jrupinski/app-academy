require "player"

describe Player do
  it "creates a player with given name" do
    expect { Player.new("name") }.to_not raise_error 
    expect { Player.new }.to raise_error ArgumentError
    expect { Player.new(123) }.to raise_error Player::InvalidNameError

    expect(Player.new("name").name).to eq("name")
    expect(Player.new("").name).to eq("")
  end
end
