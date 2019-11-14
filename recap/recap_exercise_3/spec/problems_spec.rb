require "problems"

describe "RECAP EXERCISE 3" do
  describe "General Problems:" do
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
        expect(vigenere_cipher("ZeBrA", [3, 0])).to eq("CeErD")
        expect(vigenere_cipher("y%@wn", [1])).to eq("z%@xo")
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

    describe "vowel_rotate" do
      it "should accept a string as an arg" do
        expect { vowel_rotate("string") }.to_not raise_error
      end

      it "should return a string where each vowel is replaced by it's predecessor" do
        expect(vowel_rotate("elo")).to eq("ole")
        expect(vowel_rotate('awesome')).to eq("ewasemo")
        expect(vowel_rotate('headphones')).to eq("heedphanos")
        expect(vowel_rotate('bootcamp')).to eq("baotcomp")
      end

      it "should not modify original string" do
        str = "awesome"
        vowel_rotate(str)
        expect(str).to eq("awesome")
      end
    end
  end

  describe "Proc Problems:" do
    describe "String#select" do
      it "should accept a code block as an arg" do
        "test".select { |char| char == char.upcase }
      end

      # TODO: fix this test; waiting for Stack overflow response
      # it "should not use built-in Array#select" do
      #   string = "HELLOworld".chars
      #   expect(string).to_not receive(Array:select)
      # end

      it "should return a new string containing chars of original string that eval to true when parsed into the block" do
        expect("app academy".select { |ch| !"aeiou".include?(ch) }).to eq("pp cdmy")
        expect("HELLOworld".select { |ch| ch == ch.upcase }).to eq("HELLO")
        expect("HELLOworld".select).to eq("")
      end

      it "should not modify original string" do
        str = "HiYa"
        str.select { |char| char == char.upcase }
        expect(str).to eq("HiYa")
      end
    end

    describe "String#map!" do
      it "should accept a block as an arg" do
        expect { "test".map! { |c| c = "o" if c == "e" } }.to_not raise_error
      end

      
      it "should return a string, replacing each char with the result of the block" do
        expect("test".map! { |c| (c = "o" if c == "e") || c }).to eq("tost")
        expect("test".map! { |c| c = "o" if c == "e" }).to eq("o")

        test_proc = Proc.new do |word|
          word.map! do |ch| 
              if ch == 'e'
                  '3'
              elsif ch == 'a'
                  '4'
              else
                  ch
              end
          end
        end
        
        expect("Lovelace".map!(&test_proc)).to eq("Lov3l4c3")
        expect("test".map! {}).to eq("")
      end

      it "should modify existing string" do
        word = "test"
        word_id = word.object_id
        word.map! { |c| (c = "o" if c == "e") || c }
        expect(word_id == word.object_id).to eq(true)
        expect(word).to eq("tost")
      end
    end
  end

  describe "Recursion problems:" do
    describe "multiply" do
      it "should take 2 numbers as an arg" do
        expect { multiply(1, 2) }.to_not raise_error
      end

      it "should return it's product" do
        expect(multiply(1, 2)).to eq(2)
        expect(multiply(1, 2)).to eq(2)
        expect(multiply(1, 1)).to eq(1)
        expect(multiply(-15, 1)).to eq(-15)
        expect(multiply(55, 0)).to eq(0)
        expect(multiply(0, 0)).to eq(0)
        expect(multiply(-3, -3)).to eq(9)
      end

      it "should use recursion" do
        # Doesn't work properly, TODO: research how to use without class
        # multiply.should_receive(:multiply).and_call_original
      end
      it "should not use (*) operator" do
        # Doesn't work properly, TODO: research how to use without class
        # multiply.should_not.receive(:*)
      end
    end

    describe "lucas_sequence" do
      it "should accept a length number as an arg" do
        expect { lucas_sequence(5) }.to_not raise_error
      end

      it "should have [2, 1] as it's first 2 numbers" do
        expect(lucas_sequence(0)).to eq([])
        expect(lucas_sequence(1)).to eq([2])
        expect(lucas_sequence(2)).to eq([2, 1])
      end

      it "should generate new numbers by adding previous two numbers" do
        expect(lucas_sequence(3)).to eq([2, 1, 3])
        expect(lucas_sequence(4)).to eq([2, 1, 3, 4])
        expect(lucas_sequence(5)).to eq([2, 1, 3, 4, 7])
        expect(lucas_sequence(8)).to eq([2, 1, 3, 4, 7, 11, 18, 29])
      end

      it "should use recursion" do
        # Doesn't work properly, TODO: fix this
      end
    end
  end
end
