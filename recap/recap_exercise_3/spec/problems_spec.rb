require "problems"

describe "RECAP EXERCISE 3" do
  
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

    context "if an element never appears consecutively in the array" do
      it "should return true" do
        expect(no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])).to eq(true)
        expect(no_consecutive_repeats?(['x'])).to eq(true)
        expect(no_consecutive_repeats?([])).to eq(true)
      end
    end

    context "if same element appears consecutively in the array" do
      it "should return false" do
        expect(no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])).to eq(false)
        expect(no_consecutive_repeats?([55, 55, 11, 7])).to eq(false)
        expect(no_consecutive_repeats?(["x", 53, "y", "y", 99])).to eq(false)
      end
    end
  end

  describe "char_indices" do
    it "should accept string as an arg" do
      expect { char_indices("string") }.to_not raise_error
    end

    context "should return a hash value" do
      it "should contain every char of string as a key" do
        expect(char_indices("elo").keys).to eq(["e", "l", "o"])
        expect(char_indices("bobby").keys).to eq(["b", "o", "y"])
      end

      it "should contain an array of indexes of  char appearances as value" do
        expect(char_indices("elo").values).to eq([[0], [1], [2]])
        expect(char_indices("bobby").values).to eq([[0, 2, 3], [1], [4]])
      end
    end
  end
end
