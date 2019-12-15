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
      expect { test_item.title = "changed_title" }.to_not raise_error
      expect(test_item.title).to eq("changed_title")
    end
  end
  
  describe "#deadline" do
    test_item = Item.new("test_item", "2007-03-22", "description")
    it "returns deadline from Item object" do
      expect(test_item.deadline).to eq("2007-03-22")
    end

    it "allows to modify the deadline using =" do
      expect { test_item.deadline = "1999.05.05" }.to raise_error Item::InvalidDateError
      expect { test_item.deadline = "1999-05-05" }.to_not raise_error
      expect(test_item.deadline).to eq("1999-05-05")
    end
  end

  describe "#description" do
    test_item = Item.new("test_item", "2007-03-22", "description")
    it "returns description from Item object" do
      expect(test_item.description).to eq("description")
    end

    it "allows to modify the description using =" do
      expect { test_item.title = "changed description" }.to_not raise_error
      expect(test_item.title).to eq("changed description")
    end
  end
end