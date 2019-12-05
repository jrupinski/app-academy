require "meddling_medley"

context "Phase 1: Modest problems" do
  describe "duos" do
    it "accepts a string as an argument" do
      expect { duos("test") }.to_not raise_error
    end

    it "returns the count of the number of times the same character appears consecutively in the given string." do
      expect(duos('bootcamp')).to eq(1)
      expect(duos('wxxyzz')).to eq(2)
      expect(duos('hoooraay')).to eq(3)
      expect(duos('dinosaurs')).to eq(0)
      expect(duos('e')).to eq(0)
    end
  end

  describe "sentence_swap" do
    it "accepts a sentence and a hash as arguments" do
      expect {
        sentence_swap('anything you can do I can do',
          'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
      ) }.to_not raise_error
    end

    it "returns a new sentence where every word is replaced with it's corresponding value in the hash" do
      expect(sentence_swap('anything you can do I can do',
          'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
      )).to eq('nothing you shall drink I shall drink')

      expect(sentence_swap('what a sad ad',
          'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
      )).to eq('make a happy ad')

      expect(sentence_swap('keep coding okay',
          'coding'=>'running', 'kay'=>'pen'
      )).to eq('keep running okay')
    end

    it "if a word does not exist as a key of the hash, then it should remain unchanged" do
      expect(sentence_swap('hello world',
          'dog'=>'cat', 'boot'=>'shoe'
      )).to eq('hello world')
    end
  end

  describe "hash_mapped" do
    double = Proc.new { |n| n * 2 }
    first = Proc.new { |a| a[0] }

    it "accepts a hash, a proc, and a block" do
      expect { hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' } }.to_not raise_error
    end

    it "returns a new hash where each key is the result of the original key when given to the block. Each value of the new hash should be the result of the original values when passed into the proc" do
      expect(hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }).to eq({"A!!"=>8, "X!!"=>14, "C!!"=>-6})

      expect(hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }).to eq({25=>"q", 36=>"w"})
    end
  end

  describe "counted_characters" do
    it "accepts a string as an argument" do
      expect { counted_characters("string") }.to_not raise_error
    end

    it "returns an array containing the characters of the string that appeared more than twice. The characters in the output array should appear in the same order they occur in the input string" do
      expect(counted_characters("that's alright folks")).to eq(["t"])
      expect(counted_characters("mississippi")).to eq(["i", "s"])
      expect(counted_characters("hot potato soup please")).to eq(["o", "t", " ", "p"])
      expect(counted_characters("runtime")).to eq([])
    end
  end

  describe "triplet_true?" do
    it "accepts a string as an argument" do
      expect { triplet_true?("test") }.to_not raise_error
    end

    it "returns a boolean indicating whether or not the string contains three of the same character consecutively" do
      expect(triplet_true?('caaabb')).to eq(true)
      expect(triplet_true?('terrrrrible')).to eq(true)
      expect(triplet_true?('runninggg')).to eq(true)
      expect(triplet_true?('bootcamp')).to eq(false)
      expect(triplet_true?('e')).to eq(false)
    end
  end

  describe "energetic_encoding" do
    it "accepts a string and a hash as arguments" do
      expect { energetic_encoding('sent sea',
        'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
      ) }.to_not raise_error
    end

    it "return a new string where characters of the original string are replaced with the corresponding values in the hash. If char is not a key in hash - replace it with \"?\"" do
      expect(energetic_encoding('sent sea',
          'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
      )).to eq('zimp ziu')

      expect(energetic_encoding('cat',
          'a'=>'o', 'c'=>'k'
      )).to eq('ko?')

      expect(energetic_encoding('hello world',
          'o'=>'i', 'l'=>'r', 'e'=>'a'
      )).to eq('?arri ?i?r?')

      expect(energetic_encoding('bike', {})).to eq('????')
    end
  end

  describe "uncompress" do
    it "accepts a string as an argument. The string will be formatted so every letter is followed by a number" do
      expect { uncompress('a2b4c1') }.to_not raise_error
    end

    it "return an \"uncompressed\" version of the string where every letter is repeated multiple times given based on the number that appears directly after the letter" do
      expect(uncompress('a2b4c1')).to eq'aabbbbc'
      expect(uncompress('b1o2t1')).to eq'boot'
      expect(uncompress('x3y1x2z4')).to eq'xxxyxxzzzz'
    end
  end
end

context "Phase 2: More difficult, maybe?" do
  describe "conjunct_select" do
    let (:is_positive) { Proc.new { |n| n > 0 } }
    let (:is_odd) { Proc.new { |n| n.odd? } }
    let (:less_than_ten) { Proc.new { |n| n < 10 } }

    it "accepts an array and one or more procs as arguments" do
      expect { conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) }.to_not raise_error
    end

    it "returns a new array containing the elements that return true when passed into all of the given procs" do
      expect(conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive)).to eq([4, 8, 11, 7, 13])
      expect(conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd)).to eq([11, 7, 13])
      expect(conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten)).to eq([7])
    end
  end

  describe "convert_pig_latin" do
    it "accepts a sentence as an argument" do
      expect { convert_pig_latin("test sentence") }.to_not raise_error
    end

    context "the method should translate the sentence according to the following rules:" do
      it "words that are shorter than 3 characters are unchanged" do
        expect(convert_pig_latin("yo")).to eq("yo")
      end

      context "words that are 3 characters or longer are translated according to the following rules:" do
        it "if the word begins with a vowel, simply add 'yay' to the end of the word" do
          expect(convert_pig_latin("eat")).to eq("eatyay")
        end

        it "if the word begins with a non-vowel, move all letters that come before the word's first vowel to the end of the word and add 'ay'" do
          expect(convert_pig_latin("trash")).to eq("ashtray")
        end
      end
      
      it "if words are capitalized in the original sentence, they should remain capitalized in the translated sentence" do
        expect(convert_pig_latin('We like to eat bananas')).to eq("We ikelay to eatyay ananasbay")
        expect(convert_pig_latin('I cannot find the trash')).to eq("I annotcay indfay ethay ashtray")
        expect(convert_pig_latin('What an interesting problem')).to eq("Atwhay an interestingyay oblempray")
        expect(convert_pig_latin('Her family flew to France')).to eq("Erhay amilyfay ewflay to Ancefray")
        expect(convert_pig_latin('Our family flew to France')).to eq("Ouryay amilyfay ewflay to Ancefray")
      end
    end
  end
end 