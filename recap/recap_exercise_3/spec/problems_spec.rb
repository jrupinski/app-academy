require "problems"

describe "Recap Exercise 3" do
  let(:dupes_arr) { [1,3,6,3,8] }
  describe "no_dupes?" do
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

end