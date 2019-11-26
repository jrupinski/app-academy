describe "phase_4" do
  describe "mersenne_prime" do
    it "accepts a positive number as an arg" do
      expect { mersenne_prime(2) }.to_not raise_error
      expect { mersenne_prime(-2) }.to raise_error("num has to be positive")
    end

    it "returns n-th Mersenne prime number" do
      expect(mersenne_prime(1)).to eq(3)
      expect(mersenne_prime(2)).to eq(7)
      expect(mersenne_prime(3)).to eq(31)
      expect(mersenne_prime(4)).to eq(127)
      expect(mersenne_prime(6)).to eq(131071)
    end
  end

  describe "triangular_word?" do
    it "accepts a lowercase word as an arg" do
      expect { triangular_word?("cat") }.to_not raise_error
    end

    it "returns a bool indicating if number encoded word is a triangular number" do
      expect(triangular_word?('abc')).to eq(true)
      expect(triangular_word?('ba')).to eq(true)
      expect(triangular_word?('lovely')).to eq(true)
      expect(triangular_word?('question')).to eq(true)
      expect(triangular_word?('aa')).to eq(false)
      expect(triangular_word?('cd')).to eq(false)
      expect(triangular_word?('cat')).to eq(false)
      expect(triangular_word?('sink')).to eq(false)
    end
  end

  describe "triangular_number?" do
    it "accepts a number as an arg" do
      expect { triangular_number?(5) }.to_not raise_error
    end

    it "returns a bool indicating if number is a triangular number" do
      expect(triangular_number?(1)).to eq(true)
      expect(triangular_number?(3)).to eq(true)
      expect(triangular_number?(6)).to eq(true)
      expect(triangular_number?(10)).to eq(true)
      expect(triangular_number?(15)).to eq(true)
      expect(triangular_number?(2)).to eq(false)
      expect(triangular_number?(4)).to eq(false)
      expect(triangular_number?(5)).to eq(false)
    end
  end

  describe "consecutive_collapse" do
    it "accepts an array of numbers as an arg" do
      expect { consecutive_collapse([3, 4, 1]) }.to_not raise_error
      expect { consecutive_collapse("test") }.to raise_error
    end

    it "return a new array, with every leftmost adjacent consecutive numbers removed" do
      expect(consecutive_collapse([3, 4, 1])).to eq([1])
      expect(consecutive_collapse([1, 4, 3, 7])).to eq([1, 7])
      expect(consecutive_collapse([9, 8, 2])).to eq([2])
      expect(consecutive_collapse([9, 8, 4, 5, 6])).to eq([6])
      expect(consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])).to eq([1, 9, 2])
      expect(consecutive_collapse([3, 5, 6, 2, 1])).to eq([1])
      expect(consecutive_collapse([5, 7, 9, 9])).to eq([5, 7, 9, 9])
      expect(consecutive_collapse([13, 11, 12, 12])).to eq([])
    end
  end

  describe "pretentious_primes" do
    it "accepts an array and a number as an arg" do
      expect { pretentious_primes([4, 15, 7], 1) }.to_not raise_error
      expect { pretentious_primes("test", [1, 2, 3]) }.to_not raise_error
    end

    context "returns a new array where each element of the original array is replaced:" do
      it "when num arg is positive, replace an element with the n-th nearest prime number that is greater than the element" do
        expect(pretentious_primes([4, 15, 7], 1)).to eq([5, 17, 11])
        expect(pretentious_primes([4, 15, 7], 2)).to eq([7, 19, 13])
        expect(pretentious_primes([12, 11, 14, 15, 7], 1)).to eq([13, 13, 17, 17, 11])
        expect(pretentious_primes([12, 11, 14, 15, 7], 3)).to eq([19, 19, 23, 23, 17])
      end

      it "when num arg is negative, replace an element with the n-th nearest prime number that is less than the element" do
        expect(pretentious_primes([4, 15, 7], -1)).to eq([3, 13, 5])
        expect(pretentious_primes([4, 15, 7], -2)).to eq([2, 11, 3])
        expect(pretentious_primes([2, 11, 21], -1)).to eq([nil, 7, 19])
        expect(pretentious_primes([32, 5, 11], -3)).to eq([23, nil, 3])
        expect(pretentious_primes([32, 5, 11], -4)).to eq([19, nil, 2])
        expect(pretentious_primes([32, 5, 11], -5)).to eq([17, nil, nil])
      end
    end
  end
end