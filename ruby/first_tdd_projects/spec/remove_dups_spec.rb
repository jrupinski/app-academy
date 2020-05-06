require "remove_dups"

describe "my_uniq" do
  subject(:elements) { [1, 2, 1, 3, 3] }
  
  it "removes duplicates from the array" do
    expect(my_uniq(elements)).to eq([1, 2, 3])
  end

  it "returns unique elements in the order in which they first appeared" do
    elements = [3, 1, 2, 1, 2, 3]
    expect(my_uniq(elements)).to eq([3, 1, 2])
  end

  it "does not modify original array" do
    expect(my_uniq(elements)).to_not be(elements)
    expect(elements).to eq([1, 2, 1, 3, 3])
  end
end