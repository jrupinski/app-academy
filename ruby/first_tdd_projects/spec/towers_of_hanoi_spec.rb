require "towers_of_hanoi"

describe "Towers of Hanoi" do
  subject(:hanoi) { TowersOfHanoi.new }

  it "Creates an instance of Tower of Hanoi" do
    expect { hanoi }.to_not raise_error
    expect(hanoi.towers).to be_an(Array)
    expect(hanoi.towers.all? { |tower| tower.is_a?(Array) }).to be true
  end

  it "Starts with only first tower populated" do 
    expect(hanoi.towers.first).to_not be_empty
    expect(hanoi.towers.one? { |tower| !tower.empty? }).to be true
  end

  it "Moves only one disk at a time" do
    hanoi.move(0, 2)
    expect(hanoi.towers).to eq([[3, 2], [], [1]])    
  end

  it "Doesn't allow placing larger disks on top of a smaller disk" do
    # towers: [3], [1], [2]
    hanoi.move(0, 1)
    hanoi.move(0, 2)

    expect { hanoi.move(2, 1) }.to raise_error(ArgumentError)
    expect { hanoi.move(0, 1) }.to raise_error(ArgumentError)
    expect { hanoi.move(1, 0) }.to_not raise_error
    expect { hanoi.move(0, 2) }.to_not raise_error
  end

  it "Allows Only one disk to be moved at a time." do
    expect { hanoi.move(-1, 1) }.to raise_error(IndexError)
    expect { hanoi.move(0, 3) }.to raise_error(IndexError)
    hanoi.move(0, 2)
    expect(hanoi.towers).to eq([[3, 2], [], [1]])
  end

  it "Wins if all discs are on the last tower" do
    expect(hanoi.won?).to be false
    allow(hanoi).to receive(:towers).and_return([[], [3, 2, 1], []])
    expect(hanoi.won?).to be false
    allow(hanoi).to receive(:towers).and_return([[], [], [3, 2, 1]])
    expect(hanoi.won?).to be true
  end
end