require "phase_1"

describe "Phase_1" do
  describe "strange_sums" do
    it "accepts an array of nums as an arg" do
      expect { strange_sums([9]) }.to_not raise_error
    end

    it "returns a count of distinct pairs of elements where sum equals zero" do
      expect(strange_sums([9])).to eq(0)      
      expect(strange_sums([1, 3, -1, 9, -3])).to eq(2)
      expect(strange_sums([19, 6, -3, -20])).to eq(0)
      expect(strange_sums([-5, 5])).to eq(1)
      expect(strange_sums([42, 3, -1, -42])).to eq(1)
    end
  end

  describe "pair_product" do
    it "accepts an array of nums and a product as args" do
      expect { pair_product([3, 4], 12) }.to_not raise_error
    end

    it "returns a boolean indicating if any distinct pair of elements results in the product" do
      expect(pair_product([4, 2, 5, 8], 16)).to eq(true)
      expect(pair_product([8, 1, 9, 3], 8)).to eq(true)
      expect(pair_product([3, 4], 12)).to eq(true)
      expect(pair_product([3, 4, 6, 2, 5], 12)).to eq(true)
      expect(pair_product([4, 2, 5, 7], 16)).to eq(false)
      expect(pair_product([8, 4, 9, 3], 8)).to eq(false)
      expect(pair_product([3], 12)).to eq(false)
    end
  end

  describe "rampant_repeats" do
    it "accepts a string and a hash as args" do
      expect { rampant_repeats('taco', {'a'=>3, 'c'=>2}) }.to_not raise_error
    end

    it "returns a new string where chars of original string is multiplied by times specified in hash" do
      expect(rampant_repeats('taco', {'a'=>3, 'c'=>2})).to eq('taaacco')
      expect(rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3})).to eq('ffffeeveerisssh')
      expect(rampant_repeats('misispi', {'s'=>2, 'p'=>2})).to eq('mississppi')
      expect(rampant_repeats('faarm', {'e'=>3, 'a'=>2})).to eq('faaaarm')
    end
  end

  describe "perfect_square?" do
    it "accepts a number as an arg" do
      expect { perfect_square?(3) }.to_not raise_error
    end

    it "returns a boolean indicating if given number is a perfect square" do
      expect(perfect_square?(1)).to eq(true)
      expect(perfect_square?(4)).to eq(true)
      expect(perfect_square?(64)).to eq(true)
      expect(perfect_square?(100)).to eq(true)
      expect(perfect_square?(169)).to eq(true)
      expect(perfect_square?(2)).to eq(false)
      expect(perfect_square?(40)).to eq(false)
      expect(perfect_square?(32)).to eq(false)
      expect(perfect_square?(50)).to eq(false)
    end
  end
end
