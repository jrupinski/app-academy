require "player"

describe Player do
  it "creates a player with given name" do
    expect { Player.new("name") }.to_not raise_error
    expect { Player.new }.to raise_error
    expect { Player.new(123) }.to raise_error

    expect(Player.new("name")).to eq("name")
    expect(Player.new("")).to eq("name")
  end
end
