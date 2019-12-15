require "item"

describe "Item" do
  it "returns a new ToDoBoard Item with a title, deadline and a description" do
    expect { Item.new }.to raise_error ArgumentError
    expect { Item.new("1990-10-03", "description") }.to raise_error ArgumentError
    expect { Item.new("test_item", "1990-10-03") }.to raise_error ArgumentError
    expect { Item.new("1990-10-03") }.to raise_error ArgumentError
    expect { Item.new("test_item", "1990.10.03", "description") }.to raise_error Item::InvalidDateError
    expect { Item.new("test_item", "2007-03-22", "description") }.to_not raise_error
  end

  describe "::valid_date?" do
    it "returns a Boolean indicating if date given as argument is valid (YYYY-MM-DD format)" do
      expect(Item.valid_date?('2019-10-25')).to eq(true)
      expect(Item.valid_date?('1912-06-23')).to eq(true)
      expect(Item.valid_date?('2018-13-20')).to eq(false)
      expect(Item.valid_date?('2018-12-32')).to eq(false)
      expect(Item.valid_date?('10-25-2019')).to eq(false)
    end
  end

  describe "#title" do
    test_item = Item.new("test_item", "2007-03-22", "description")
    it "returns title from Item object" do
      expect(test_item.title).to eq("test_item")
    end

    it "allows to modify the title using =" do
      expect { test_item.title = "test_title" }.to_not raise_error
      expect(test_item.title).to eq("test_title")
    end
  end
end