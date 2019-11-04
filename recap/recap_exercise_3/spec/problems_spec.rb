require "problems"

describe "Recap Exercise 3" do
  
  describe "no_dupes?" do
    dupes_arr = [1,3,6,3,8]

    it "accepts an array as an arg" do
      expect { no_dupes?(dupes_arr) }.to_not raise_error
    end
    
    it "returns a new array containing distinct elements only" do
      expect(no_dupes?(dupes_arr)).to eq([1,6,8])
      expect(no_dupes?([1,1,1,1])).to eq([])
      expect(no_dupes?([1, 2, 3])).to eq([1,2,3])
    end
    
    it "does not modify original array" do
      expect(dupes_arr).to eq([1,3,6,3,8])
    end
  end

  describe "no_consecutive_repeats?" do
    it "accepts an array as an arg" do
      expect { no_consecutive_repeats?([10, 2]) }.to_not raise_error
    end

    it "returns true if an element never appears consecutively in the array" do
      expect(no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])).to eq(true)
      expect(no_consecutive_repeats?(['x'])).to eq(true)
      expect(no_consecutive_repeats?([])).to eq(true)
    end

    it "returns false if same element appears consecutively in the array" do
      expect(no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])).to eq(false)
      expect(no_consecutive_repeats?([55, 55, 11, 7])).to eq(false)
      expect(no_consecutive_repeats?(["x", 53, "y", "y", 99])).to eq(false)
    end
  end

end