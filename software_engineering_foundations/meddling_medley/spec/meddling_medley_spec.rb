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
end