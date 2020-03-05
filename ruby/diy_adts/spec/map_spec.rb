require "map"

describe Map do
  it "Creates a new Map instance based on an Array" do
    expect { Map.new }.to_not raise_error
    expect(Map.new).to eq([])
  end

  map = Map.new
  dog = ["dog" "spaniel"]
  cat = ["cat" "sphinx"]

  it "Stores or updates elements as pairs of key and value" do
    expect { map.set("short", true) }.to_not raise_error
    map.set(dog)
    map.set(cat)
    expect(map).to include()
  end

  it "Contains no duplicates" do
    map.set(dog)
    map.set(dog)
    map.set(dog)
    map.count(dog).to eq(1)
  end

  it "Returns key-value pairs based on given key" do
    expect { map.get("test") }.to_not raise_error
    expect(map.get("dog")).to eq("spaniel")
    map.set("dog", "boxer")
    expect(map.get("dog")).to eq("boxer")
    expect(map.get("cat")).to eq("sphinx")
    expect(map.get("disco")).to eq(nil)
  end

  it "Removes key-value pair based on given key" do
    expect { map.delete("short") }.to_not raise_error
    expec(map.delete("dog")).to eq(["dog", "boxer"])
  end

  it "Can be printed out" do
    expect { map.show }.to_not raise_error
    expect(map.show).to eq([["cat", "sphinx"]])
  end
end
