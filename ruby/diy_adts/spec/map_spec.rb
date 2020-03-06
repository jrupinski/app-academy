require "map"

describe Map do
  it "Creates a new Map instance based on an Array" do
    expect { Map.new }.to_not raise_error
    expect(Map.new.is_a?(Map)).to eq(true)
  end

  let(:map) { Map.new }
  let(:map_array) { map.instance_variable_get(:@map) }

  context "Value storing" do
    it "Stores elements as pairs of key and value" do
      expect { map.set("short", true) }.to_not raise_error
      map.set("dog", "spaniel")
      map.set("cat", "sphinx")
      expect(map_array.all? { |ele| ele.is_a?(Array) && ele.size == 2 }).to eq(true)
    end

    it "Updates values instead when given existing key (no duplicates)" do
      map.set("dog", "pitbull")
      map.set("dog", "corgi")
      map.set("cat", "sphinx")
      map.set("cat", "persian")
      map.set("cat", "parmezan")
      expect(map_array.size).to eq(2)
    end
  end

  it "Returns key-value pairs based on given key" do
    map.set("dog", "spaniel")
    map.set("cat", "sphinx")
    expect { map.get("cat") }.to_not raise_error
    expect(map.get("dog")).to eq("spaniel")
    
    map.set("dog", "boxer")
    expect(map.get("dog")).to eq("boxer")
    expect(map.get("cat")).to eq("sphinx")
    expect(map.get("disco")).to eq(nil)
  end

  it "Removes key-value pair based on given key" do
    map.set("dog", "boxer")
    map.set("short", true)
    map.set("cat", "persian")

    expect { map.delete("short") }.to_not raise_error
    expect(map.delete("dog")).to eq(["dog", "boxer"])
    expect(map.delete("ice_age_baby")).to eq(nil)
    expect(map_array.size).to eq(1)
  end

  it "Allows to return entire map" do
    map.set("short", true)
    map.set("dog", "boxer")
    expect { map.show }.to_not raise_error
    expect(map.show).to eq(map_array)
  end
end
