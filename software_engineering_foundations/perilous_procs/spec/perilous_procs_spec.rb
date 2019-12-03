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

  describe "proctition" do
    it "accepts an array and a block as arguments" do
      expect { proctition([7, 8, 3, 6, 10]) { |el| el.even? } }.to_not raise_error
    end

    it "returns a new array where elements of the original array that return true when run through block are moved before rest" do
      expect(proctition([4, -5, 7, -10, -2, 1, 3]) { |el| el > 0 }).to eq([4, 7, 1, 3, -5, -10, -2])
      expect(proctition([7, 8, 3, 6, 10]) { |el| el.even? }).to eq([8, 6, 10, 7, 3])
    end

    it "does not modify original array" do
      arr = [4, 3, 2, 7]
      expect { proctition(arr) { |num| num.even? } }.to_not change { arr }
    end
  end
end

context "phase 3" do
  describe "selected_map!" do
    let(:is_even) { Proc.new { |n| n.even? } }
    let(:is_positive) { Proc.new { |n| n > 0 } }
    let(:square) { Proc.new { |n| n * n } }
    let(:flip_sign) { Proc.new { |n| -n } }
    
    it "accepts an array and two procs as arguments" do
      expect { selected_map!([1, 2, 3], is_even, square) }.to_not raise_error
    end

    it "mutates the original array, and replaces elements that return true when passed into first proc with result of the second proc" do
      arr_1 = [8, 5, 10, 4]
      expect{ selected_map!(arr_1, is_even, square) }.to change { arr_1 }.to([64, 5, 100, 16])

      arr_2 = [-10, 4, 7, 6, -2, -9]
      expect{ selected_map!(arr_2, is_even, flip_sign) }.to change { arr_2 }.to([10, -4, 7, -6, 2, -9])

      arr_3 = [-10, 4, 7, 6, -2, -9]
      expect{ selected_map!(arr_3, is_positive, square) }.to change { arr_3 }.to([-10, 16, 49, 36, -2, -9])
    end

    it "returns nil after executing" do
      expect(selected_map!([1, 2, 3], is_even, square)).to eq(nil)
    end
  end

  describe "chain_map" do
    let (:add_5) { Proc.new { |n| n + 5 } }
    let (:half) { Proc.new { |n| n / 2.0 } }
    let (:square) { Proc.new { |n| n * n } }

    it "accepts any value and an array of procs as an argument" do
      expect { chain_map(25, [add_5, half]) }.to_not raise_error
    end

    it "returns the final result of feeding the value through all of the procs" do
      expect(chain_map(25, [add_5, half])).to eq(15.0)
      expect(chain_map(25, [half, add_5])).to eq(17.5)
      expect(chain_map(25, [add_5, half, square])).to eq(225)
      expect(chain_map(4, [square, half])).to eq(8)
      expect(chain_map(4, [half, square])).to eq(4)
    end
  end

  describe "proc_suffix" do
    let (:contains_a) { Proc.new { |w| w.include?('a') } }
    let (:three_letters) { Proc.new { |w| w.length == 3 } }
    let (:four_letters) { Proc.new { |w| w.length == 4 } }

    it "accepts a sentence and a hash as arguments" do
      expect { proc_suffix("test sentence", contains_a => 'to') }.to_not raise_error
    end

    it "returns a new sentence" do
      sentence = "cat"
      expect { proc_suffix(sentence, contains_a => 'to') }.to_not change { sentence }
    end

    it "appends a suffix to each word if original word returns true when given to the corresponding proc key" do
      expect(proc_suffix('dog cat',
          contains_a => 'ly',
          three_letters => 'o'
      )).to eq("dogo catlyo")

      expect(proc_suffix('dog cat',
          three_letters => 'o',
          contains_a => 'ly'
      )).to eq("dogo catoly")

      expect(proc_suffix('wrong glad cat',
          contains_a => 'ly',
          three_letters => 'o',
          four_letters => 'ing'
      )).to eq("wrong gladlying catlyo")

      expect(proc_suffix('food glad rant dog cat',
          four_letters => 'ing',
          contains_a => 'ly',
          three_letters => 'o'
      )).to eq("fooding gladingly rantingly dogo catlyo")
    end
  end

  describe "proctition_platinum" do
    let (:is_yelled) { Proc.new { |s| s[-1] == '!' } }
    let (:is_upcase) { Proc.new { |s| s.upcase == s } }
    let (:contains_a) { Proc.new { |s| s.downcase.include?('a') } }
    let (:begins_w) { Proc.new { |s| s.downcase[0] == 'w' } }

    it "accepts an array and any number of additional procs as arguments" do
      expect { proctition_platinum(
        ['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], 
        is_yelled, is_upcase, contains_a) }.to_not raise_error
    end

    context "returns a hash where:" do
      it "values contain an array with elements of array that returns true when passed to corresponding proc" do
        expect(proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], 
        is_yelled, contains_a)).to eq({1=>["when!", "WHERE!"], 2=>["what"]})
        
        expect(proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], 
        is_yelled, is_upcase, contains_a)).to eq({1=>["when!", "WHERE!"], 2=>["WHO", "WHY"], 3=>["what"]})
        
        expect(proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], 
        is_upcase, is_yelled, contains_a)).to eq({1=>["WHO", "WHERE!", "WHY"], 2=>["when!"], 3=>["what"]})
        
        expect(proctition_platinum(['WHO', 'what', 'when!', 'WHERE!', 'how', 'WHY'], 
        begins_w, is_upcase, is_yelled, contains_a)).to eq({1=>["WHO", "what", "when!", "WHERE!", "WHY"], 2=>[], 3=>[], 4=>[]})
      end

      it "keys are equal to number of procs passed in (starting from 1)" do
        expect(proctition_platinum(['WHO', 'when!'], is_yelled).keys).to eq([1])
        expect(proctition_platinum(['WHO', 'when!'], is_yelled, contains_a).keys).to eq([1, 2])
        expect(proctition_platinum(['WHO', 'when!'], is_yelled, contains_a, begins_w).keys).to eq([1, 2, 3])
      end
      
      it "value appears only in first proc key where it returned true" do
        expect(proctition_platinum(['WHO!', 'when!', 'WHERE!', 'how'], 
        is_upcase, is_yelled)).to eq({1=>["WHO!", "WHERE!"], 2=>["when!"]})
      end
    end
  end

  describe "procipher" do
  let(:is_yelled) { Proc.new { |s| s[-1] == '!' } }
  let(:is_upcase) { Proc.new { |s| s.upcase == s } }
  let(:contains_a) { Proc.new { |s| s.downcase.include?('a') } }
  let(:make_question) { Proc.new { |s| s + '???' } }
  let(:reverse) { Proc.new { |s| s.reverse } }
  let(:add_smile) { Proc.new { |s| s + ':)' } }

    it "accepts a sentence and a hash of procs(both as key and val) as arguments" do
      expect {        
        procipher('he said what!',
            is_yelled => make_question,
            contains_a => reverse
        )
      }.to_not raise_error
    end

    it "returns a new sentence where each word of the input sentence is changed by a value proc if the original word returns true when passed into the key proc." do
      expect(procipher('he said what!',
          is_yelled => make_question,
          contains_a => reverse
      )).to eq("he dias ???!tahw")

      expect(procipher('he said what!',
          contains_a => reverse,
          is_yelled => make_question
      )).to eq("he dias !tahw???")

      expect(procipher('he said what!',
          contains_a => reverse,
          is_yelled => add_smile
      )).to eq("he dias !tahw:)")

      expect(procipher('stop that taxi now',
          is_upcase => add_smile,
          is_yelled => reverse,
          contains_a => make_question
      )).to eq("stop that??? taxi??? now")

      expect(procipher('STOP that taxi now!',
          is_upcase => add_smile,
          is_yelled => reverse,
          contains_a => make_question
      )).to eq("STOP:) that??? taxi??? !won")
    end
  end

  describe "picky_procipher" do
    let (:is_yelled) { Proc.new { |s| s[-1] == '!' } }
    let (:is_upcase) { Proc.new { |s| s.upcase == s } }
    let (:contains_a) { Proc.new { |s| s.downcase.include?('a') } }
    let (:make_question) { Proc.new { |s| s + '???' } }
    let (:reverse) { Proc.new { |s| s.reverse } }
    let (:add_smile) { Proc.new { |s| s + ':)' } }

    it "accepts a sentence and a hash as arguments" do
      expect { picky_procipher('he said what!',
          is_yelled => make_question,
          contains_a => reverse
      ) }.to_not raise_error
    end

    it "returns a new sentence where each word of the input sentence is changed by the first value proc where the original word returns true when passed into the key proc." do
      expect(picky_procipher('he said what!',
          is_yelled => make_question,
          contains_a => reverse
      )).to eq("he dias what!???")

      expect(picky_procipher('he said what!',
          contains_a => reverse,
          is_yelled => make_question
      )).to eq("he dias !tahw")

      expect(picky_procipher('he said what!',
          contains_a => reverse,
          is_yelled => add_smile
      )).to eq("he dias !tahw")

      expect(picky_procipher('stop that taxi now',
          is_upcase => add_smile,
          is_yelled => reverse,
          contains_a => make_question
      )).to eq("stop that??? taxi??? now")

      expect(picky_procipher('STOP that taxi!',
          is_upcase => add_smile,
          is_yelled => reverse,
          contains_a => make_question
      )).to eq("STOP:) that??? !ixat")
    end
  end
end
