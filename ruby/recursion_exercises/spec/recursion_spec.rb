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
      expect(Recursion).to receive(:fibonacci_recursive).at_least(:twice)
      Recursion.fibonacci_recursive(5)
    end
  end
end
