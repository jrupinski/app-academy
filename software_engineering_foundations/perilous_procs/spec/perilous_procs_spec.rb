require "perilous_procs"

describe "phase 1" do
  describe "some?" do
    it "accepts an array and a block as arguments" do
      expect { some?([3, 1, 11, 5]) { |n| n.even? } }.to_not raise_error
    end

    it "return a boolean indicating if any element is true when given to block" do
      expect(some?([3, 1, 11, 5]) { |n| n.even? }).to eq(false)
      expect(some?([3, 4, 11, 5]) { |n| n.even? }).to eq(true)
      expect(some?([8, 2]) { |n| n.even? }).to eq(true)
      expect(some?(['squash', 'corn', 'kale', 'carrot']) { |str| str[0] == 'p' }).to eq(false)
      expect(some?(['squash', 'corn', 'kale', 'potato']) { |str| str[0] == 'p' }).to eq(true)
      expect(some?(['parsnip', 'lettuce', 'pea']) { |str| str[0] == 'p' }).to eq(true)
    end

    it "uses Array#each" do
      arr = [3, 1, 11, 5]
      expect(arr).to receive(:each).at_least(:once)
      some?(arr) { |n| n.even? }
    end
  end

  describe "exactly?" do
    it "accepts an array, a number, and a block as arguments" do
      expect { exactly?(['A', 'b', 'C'], 2) { |el| el == el.upcase } }.to_not raise_error
    end

    it "return a boolean indicating if there are exactly n elements that return true when given to block" do
      expect(exactly?(['A', 'b', 'C'], 2) { |el| el == el.upcase }).to eq(true)
      expect(exactly?(['A', 'B', 'C'], 2) { |el| el == el.upcase }).to eq(false)
      expect(exactly?(['A', 'B', 'C'], 3) { |el| el == el.upcase }).to eq(true)
      expect(exactly?(['cat', 'DOG', 'bird'], 1) { |el| el == el.upcase }).to eq(true)
      expect(exactly?(['cat', 'DOG', 'bird'], 0) { |el| el == el.upcase }).to eq(false)
      expect(exactly?(['cat', 'dog', 'bird'], 0) { |el| el == el.upcase }).to eq(true)
      expect(exactly?([4, 5], 3) { |n| n > 0 }).to eq(false)
      expect(exactly?([4, 5, 2], 3) { |n| n > 0 }).to eq(true)
      expect(exactly?([42, -9, 7, -3, -6], 2) { |n| n > 0 }).to eq(true)
    end

    it "uses Array#each" do
      arr = ['A', 'b', 'C']
      expect(arr).to receive(:each).at_least(:once)
      exactly?(arr, 2) { |el| el == el.upcase }
    end
  end

  describe "filter_out" do
    it "accepts an array and a block as arguments" do
      expect { filter_out([1, 2, 3]) { |x| x.odd? } }.to_not raise_error
    end

    it "returns new array where elements of original array are removed if they equal true when giveen to block" do
      expect(filter_out([10, 6, 3, 2, 5 ]) { |x| x.odd? }).to eq([10, 6, 2])
      expect(filter_out([1, 7, 3, 5 ]) { |x| x.odd? }).to eq([])
      expect(filter_out([10, 6, 3, 2, 5 ]) { |x| x.even? }).to eq([3, 5])
      expect(filter_out([1, 7, 3, 5 ]) { |x| x.even? }).to eq([1, 7, 3, 5])
    end

    it "should use Array#each" do
      arr = [1, 2, 3, 4, 5]
      expect(arr).to receive(:each).at_least(:once)
      filter_out(arr) { |x| x.odd? }
    end
  end
end