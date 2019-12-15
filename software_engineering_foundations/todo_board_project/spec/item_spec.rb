require "item"

describe "Item" do
  describe "::valid_date?" do
    it "checks if date given as argument is valid (YYYY-MM-DD format)" do
      expect(Item.valid_date?('2019-10-25')).to eq(true)
      expect(Item.valid_date?('1912-06-23')).to eq(true)
      expect(Item.valid_date?('2018-13-20')).to eq(false)
      expect(Item.valid_date?('2018-12-32')).to eq(false)
      expect(Item.valid_date?('10-25-2019')).to eq(false)
    end
  end
end