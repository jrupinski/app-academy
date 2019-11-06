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

  describe "longest_streak" do
    it "should accept string as an arg" do
      expect { longest_streak("string") }.to_not raise_error
    end

    it  "should return the longest char streak" do
      expect(longest_streak('')).to eq('')
      expect(longest_streak('a')).to eq('a')
      expect(longest_streak('accccbbb')).to eq('cccc')
      expect(longest_streak('aaaxyyyyyzz')).to eq('yyyyy')
    end

    context "if there's a tie" do
      it "should return the streak that occurs later in str" do
        expect(longest_streak('aaabbb')).to eq('bbb')
        expect(longest_streak('abc')).to eq('c')
      end
    end
  end

  describe "bi_prime?" do
    it "should accept a number as an arg" do
      expect { bi_prime?(5) }.to_not raise_error
    end

    context "should return a boolean" do
      it "return true if number is a semi-prime (it's a product of multiplying two prime numbers)" do
        expect(bi_prime?(4)).to eq(true)
        expect(bi_prime?(6)).to eq(true)
        expect(bi_prime?(25)).to eq(true)
      end

      it "return false if number is not a semi-prime" do
        expect(bi_prime?(0)).to eq(false)
        expect(bi_prime?(96)).to eq(false)
        expect(bi_prime?(24)).to eq(false)
        expect(bi_prime?(64)).to eq(false)
      end
    end
  end

  describe "vigenere_cipher" do
    it "should accept a word and an a key-sequence array as args" do
      expect { vigenere_cipher("Testing", [1, 2, 3]) }.to_not raise_error
    end

    it "should return the encrypted message" do
      expect(vigenere_cipher("toerrishuman", [1])).to eq("upfssjtivnbo")
      expect(vigenere_cipher("toerrishuman", [1, 2])).to eq("uqftsktjvobp")
      expect(vigenere_cipher("toerrishuman", [1, 2, 3])).to eq("uqhstltjxncq")
      expect(vigenere_cipher("zebra", [3, 0])).to eq("ceerd")
      expect(vigenere_cipher("yawn", [5, 1])).to eq("dbbo")
    end
  end

  describe "cipher_char" do
    it "should accept a char and a key (int)" do
      cipher_char("a", 3)
    end

    it "should return a char swapped by key amount" do
      expect(cipher_char("a", 1)).to eq("b")
      expect(cipher_char("f", 3)).to eq("i")
      expect(cipher_char("z", 1)).to eq("a")
      expect(cipher_char("j", 26)).to eq("j")
      expect(cipher_char("%", 0)).to eq("%")
      expect(cipher_char("H", 0)).to eq("H")
      expect(cipher_char("Z", 1)).to eq("A")
      expect(cipher_char("A", 9)).to eq("J")

    end
  end

end
