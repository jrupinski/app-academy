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
      # block = Proc.new { |n| n.even? }
      expect(arr).to receive(:each).at_least(:once)
      some?(arr) { |n| n.even? }
    end
  end
end