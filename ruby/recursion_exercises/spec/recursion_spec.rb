require "recursion.rb"

describe Recursion do
  describe "::deep_dup" do
    it "accepts an Array as an arg" do
      expect { Recursion.deep_dup([1]) }.to_not raise_error
    end
    
    it "creates a complete duplicate of multi-dimensional array" do
      expect(Recursion.deep_dup([1, [2], [3, [4]]])).to eq([1, [2], [3, [4]]])
    end

    # let uses lazy evaluation - in this case it's kinda redudnant tho
    let (:original_array) { [1, [2], [3, [4]]] }
    let (:duped_array) { Recursion.deep_dup(original_array) }
    
    it "doesn't modify the original array" do
      duped_array[1] << 3
      expect(duped_array).to_not eq(original_array)
    end
  end

  describe "::fibonacci_recursive" do
    it "accepts a positive Integer as an arg" do
      expect { Recursion.fibonacci_recursive(1) }.to_not raise_error
    end

    it "returns first n-numbers in a fibonacci sequence" do
      expect(Recursion.fibonacci_recursive(-1)).to eq([])
      expect(Recursion.fibonacci_recursive(0)).to eq([])
      expect(Recursion.fibonacci_recursive(1)).to eq([0])
      expect(Recursion.fibonacci_recursive(2)).to eq([0, 1])
      expect(Recursion.fibonacci_recursive(3)).to eq([0, 1, 1])
      expect(Recursion.fibonacci_recursive(6)).to eq([0, 1, 1, 2, 3, 5])
    end

    it "Is recursive" do
      expect(Recursion).to receive(:fibonacci_recursive).at_least(:twice).and_call_original
      Recursion.fibonacci_recursive(5)
    end
  end

  describe "::bsearch" do
    it "accepts a sorted Array, and a target Integer as an arg" do
      expect { Recursion.bsearch([1,2,3], 3) }.to_not raise_error
    end

    it "returns index of given target in a sorted Array" do
      expect(Recursion.bsearch([], 3)).to eq(nil)
      expect(Recursion.bsearch([1,2,3], 0)).to eq(nil)
      expect(Recursion.bsearch([1,2,3], 1)).to eq(0)
      expect(Recursion.bsearch([1,2,3,4,5,6,7], 7)).to eq(6)
      expect(Recursion.bsearch([1,2,3,4,5,6,7], 1)).to eq(0)
      expect(Recursion.bsearch([1,2,3,4,5,6,7,8], 4)).to eq(3)
    end
  end

  describe "::merge_sort" do
    it "accepts an array of numbers" do
      expect { Recursion.merge_sort([9,7,4,2,1]) }.to_not raise_error
    end

    it "returns sorted version of the array" do
      expect(Recursion.merge_sort([1])).to eq([1])
      expect(Recursion.merge_sort([])).to eq([])
      expect(Recursion.merge_sort([9,7,4,2,1])).to eq([1,2,4,7,9])
      expect(Recursion.merge_sort([1,2,4,7,9])).to eq([1,2,4,7,9])
      expect(Recursion.merge_sort([4,7,4,7,2,9,1])).to eq([1,2,4,4,7,7,9])
    end

    it "Is recursive" do
      expect(Recursion).to receive(:merge_sort).at_least(:twice).and_call_original
      Recursion.merge_sort([9,7,4,2,1])
    end
  end

  describe "::subsets" do
    it "accepts an array of numbers" do
      expect { Recursion.subsets([9,7,4,2,1]) }.to_not raise_error
    end

    it "returns an array of arrays with all subsets of an array" do
      expect(Recursion.subsets([])).to eq([[]])
      expect(Recursion.subsets([1])).to eq([[], [1]])
      expect(Recursion.subsets([1, 2])).to eq([[], [1], [2], [1, 2]])
      expect(Recursion.subsets([1, 2, 3])).to eq([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
    end
  end

  describe "::permutations" do
    it "accepts an array of numbers" do
      expect { Recursion.permutations([9,7,4,2,1]) }.to_not raise_error
    end

    it "returns an array of arrays with all permutations of an array" do
      # make them sorted because my permutations method is in different order
      expect(Recursion.permutations([]).sort).to eq([].permutation.to_a.sort)
      expect(Recursion.permutations([1]).sort).to eq([1].permutation.to_a.sort)
      expect(Recursion.permutations([1, 2]).sort).to eq([1, 2].permutation.to_a.sort)
      expect(Recursion.permutations([1, 2, 3]).sort).to eq([1, 2, 3].permutation.to_a.sort)
    end
  end
end
