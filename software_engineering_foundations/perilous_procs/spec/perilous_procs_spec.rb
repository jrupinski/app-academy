require "perilous_procs"

context "phase 1" do
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

    it "returns a boolean indicating if there are exactly n elements that return true when given to block" do
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

    it "returns new array where elements of original array are removed if they equal true when given to block" do
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

  describe "at_least?" do
    it "accepts an array, a number, and a block as arguments" do
      expect { at_least?(['A', 'b', 'C'], 2) { |el| el == el.upcase } }.to_not raise_error
    end

    it "return a boolean indicating if there are at least n elements that return true when given to block" do
      expect(at_least?(['sad', 'quick', 'timid', 'final'], 2) { |s| s.end_with?('ly') }).to eq( false)
      expect(at_least?(['sad', 'quickly', 'timid', 'final'], 2) { |s| s.end_with?('ly') }).to eq(false)
      expect(at_least?(['sad', 'quickly', 'timidly', 'final'], 2) { |s| s.end_with?('ly') }).to eq(true)
      expect(at_least?(['sad', 'quickly', 'timidly', 'finally'], 2) { |s| s.end_with?('ly') }).to eq(true)
      expect(at_least?(['sad', 'quickly', 'timid', 'final'], 1) { |s| s.end_with?('ly') }).to eq(true)
      expect(at_least?(['sad', 'quick', 'timid', 'final'], 1) { |s| s.end_with?('ly') }).to eq(false)
      expect(at_least?([false, false, false], 3) { |bool| bool }).to eq(false)
      expect(at_least?([false, true, true], 3) { |bool| bool }).to eq(false)
      expect(at_least?([true, true, true], 3) { |bool| bool }).to eq(true)
      expect(at_least?([true, true, true, true], 3) { |bool| bool }).to eq(true)
    end

    it "uses Array#each" do
      arr = ['A', 'b', 'C']
      expect(arr).to receive(:each).at_least(:once)
      at_least?(arr, 2) { |el| el == el.upcase }
    end
  end

  describe "every?" do
    it "accepts an array and a block as arguments" do
      expect { every?([3, 1, 11, 5]) { |n| n.even? } }.to_not raise_error
    end

    it "returns a boolean indicating if all elements of array equal true when passed to block" do
      expect(every?([3, 1, 11, 5]) { |n| n.even? }).to eq(false)
      expect(every?([2, 4, 4, 8]) { |n| n.even? }).to eq(true)
      expect(every?([8, 2]) { |n| n.even? }).to eq(true)
      expect(every?(['squash', 'corn', 'kale', 'carrot']) { |str| str[0] == 'p' }).to eq(false)
      expect(every?(['squash', 'pea', 'kale', 'potato']) { |str| str[0] == 'p' }).to eq(false)
      expect(every?(['parsnip', 'potato', 'pea']) { |str| str[0] == 'p' }).to eq(true)
    end

    it "should use Array#each" do
      arr = [1, 2, 3, 4, 5]
      expect(arr).to receive(:each).at_least(:once)
      every?(arr) { |x| x.odd? }
    end
  end

  describe "at_most?" do
    it "accepts an array, a number, and a block as arguments" do
      expect { at_most?([-4, 100, -3], 1) { |el| el > 0 } }.to_not raise_error
    end

    it "returns a boolean indicating if there are at most n elements that return true when given to block" do
      expect(at_most?([-4, 100, -3], 1) { |el| el > 0 }).to eq(true)
      expect(at_most?([-4, -100, -3], 1) { |el| el > 0 }).to eq(true)
      expect(at_most?([4, 100, -3], 1) { |el| el > 0 }).to eq(false)
      expect(at_most?([4, 100, 3], 1) { |el| el > 0 }).to eq(false)
      expect(at_most?(['r', 'q', 'e', 'z'], 2) { |el| 'aeiou'.include?(el) }).to eq(true)
      expect(at_most?(['r', 'i', 'e', 'z'], 2) { |el| 'aeiou'.include?(el) }).to eq(true)
      expect(at_most?(['r', 'i', 'e', 'o'], 2) { |el| 'aeiou'.include?(el) }).to eq(false)
    end

    it "uses Array#each" do
      arr = ['A', 'b', 'C']
      expect(arr).to receive(:each).at_most(:once)
      at_most?(arr, 2) { |el| el == el.upcase }
    end
  end

  describe "first_index" do
    it "accepts an array and a block as arguments" do
      expect { first_index(['bit', 'cat', 'byte', 'below']) { |el| el.length > 3 } }.to_not raise_error
    end

    it "returns the index of the first element that equals true when passed to block" do
      expect(first_index(['bit', 'cat', 'byte', 'below']) { |el| el.length > 3 }).to eq(2)
      expect(first_index(['bitten', 'bit', 'cat', 'byte', 'below']) { |el| el.length > 3 }).to eq(0)
      expect(first_index(['bit', 'cat', 'byte', 'below']) { |el| el[0] == 'b' }).to eq(0)
      expect(first_index(['bit', 'cat', 'byte', 'below']) { |el| el.include?('a') }).to eq(1)
    end
    
    it "returns nil if no elements equal true when passed to block" do
      expect(first_index(['bitten', 'bit', 'cat', 'byte', 'below']) { |el| el.length > 6 }).to eq(nil)
      expect(first_index(['bit', 'cat', 'byte', 'below']) { |el| el[0] == 't' }).to eq(nil)
    end

    it "uses Array#each" do
      arr = ['bitten', 'bit', 'cat', 'byte', 'below']
      expect(arr).to receive(:each).at_most(:once)
      first_index(arr) { |el| el.length > 6 }
    end
  end
end

context "phase_2" do
  describe "xnor_select" do
    let (:is_even) { Proc.new { |n| n % 2 == 0 } }
    let (:is_odd) { Proc.new { |n| n % 2 != 0 } }
    let (:is_positive) { Proc.new { |n| n > 0 } }

    it "accepts an array and two procs as arguments" do
      expect { xnor_select([1, 2], is_odd, is_positive) }.to_not raise_error
    end

    it "returns a new array containing elements from original array where they 
        either return true or false when passed to both procs" do
      expect(xnor_select([8, 3, -4, -5], is_even, is_positive)).to eq([8, -5])
      expect(xnor_select([-7, -13, 12, 5, -10], is_even, is_positive)).to eq([12, -7, -13])
      expect(xnor_select([-7, -13, 12, 5, -10], is_odd, is_positive)).to eq([5, -10])
    end
  end

  describe "filter_out!" do
    it "accepts an array and a block as arguments" do
      expect { filter_out!([1, 2, 3]) { |x| x.odd? } }.to_not raise_error
    end

    it "returns mutated array where elements of original array are removed if they equal true when given to block" do
      arr_1 = [10, 6, 3, 2, 5 ]
      filter_out!(arr_1) { |x| x.odd? }
      expect(arr_1).to eq([10, 6, 2])

      arr_2 = [1, 7, 3, 5 ]
      filter_out!(arr_2) { |x| x.odd? }
      expect(arr_2).to eq([])

      arr_3 = [10, 6, 3, 2, 5 ]
      filter_out!(arr_3) { |x| x.even? }
      expect(arr_3).to eq([3, 5])

      arr_4 = [1, 7, 3, 5 ]
      filter_out!([1, 7, 3, 5 ]) { |x| x.even? }
      expect(arr_4).to eq([1, 7, 3, 5])
    end

    it "should NOT use Array#reject!" do
      arr = [1, 2, 3, 4, 5]
      expect(arr).not_to receive(:reject!)
      filter_out!(arr) { |x| x.odd? }
    end

    it "mutates original array" do
      arr = [1, 2, 3, 4, 5]
      filter_out!(arr) { |x| x.odd? }
      expect(arr).to eq([2, 4])
    end
  end

  describe "multi_map" do
    it "accepts an array, an optional number (n; default = 1), and a block as arguments" do
      expect { multi_map([1, 2, 3], 5) { |i| i * 2 } }.to_not raise_error
      expect { multi_map([1, 2, 3]) { |i| i + 2 } }.to_not raise_error
    end

    it "returns a new array where each element of the original array is run through the block n times" do
      expect(multi_map(['pretty', 'cool', 'huh?']) { |s| s + '!'}).to eq(["pretty!", "cool!", "huh?!"])
      expect(multi_map(['pretty', 'cool', 'huh?'], 1) { |s| s + '!'}).to eq(["pretty!", "cool!", "huh?!"])
      expect(multi_map(['pretty', 'cool', 'huh?'], 3) { |s| s + '!'}).to eq(["pretty!!!", "cool!!!", "huh?!!!"])
      expect(multi_map([4, 3, 2, 7], 1) { |num| num * 10 }).to eq([40, 30, 20, 70])
      expect(multi_map([4, 3, 2, 7], 2) { |num| num * 10 }).to eq([400, 300, 200, 700])
      expect(multi_map([4, 3, 2, 7], 4) { |num| num * 10 }).to eq([40000, 30000, 20000, 70000])
    end

    it "does not modify original array" do
      arr = [4, 3, 2, 7]
      expect { multi_map(arr, 1) { |num| num * 10 } }.to_not change { arr }
    end
  end
end
