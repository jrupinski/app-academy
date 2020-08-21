require "rspec"
require "lru_cache"

describe "LRU Cache" do
  it "creates a LRU Cache" do
    expect { LRUCache.new(4) }.to_not raise_error
  end

  let(:johnny_cache) { LRUCache.new(4) }

  it "adds elements to the cache" do
    expect(johnny_cache.add("I walk the line")).to_not raise_error
    expect(johnny_cache.add(5)).to_not raise_error
  end
  
  it "allows to return cache item count" do
    expect(LRUCache.new.count).to eq(0)
    expect(johnny_cache.count).to eq(2)
  end
end
  
  # johnny_cache.add([1,2,3])
  # johnny_cache.add(5)
  # johnny_cache.add(-5)
  # johnny_cache.add({a: 1, b: 2, c: 3})
  # johnny_cache.add([1,2,3,4])
  # johnny_cache.add("I walk the line")
  # johnny_cache.add(:ring_of_fire)
  # johnny_cache.add("I walk the line")
  # johnny_cache.add({a: 1, b: 2, c: 3})


  # johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]