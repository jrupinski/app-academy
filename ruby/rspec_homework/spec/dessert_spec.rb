require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:panna_cotta) { Dessert.new("Panna Cotta", 3, chef) }
  let(:chef) { double("chef") }

  describe "#initialize" do
    it "sets a type" do
      expect(panna_cotta.type).to eq("Panna Cotta")
    end

    it "sets a quantity" do
      expect(panna_cotta.quantity).to eq(3)
    end

    it "starts ingredients as an empty array" do
      expect(panna_cotta.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { panna_cotta }.to_not raise_error
      expect { Dessert.new("Pizza", "a lot", chef) }.to raise_error(ArgumentError)
    endchef
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      panna_cotta.add_ingredient("milk")
      panna_cotta.add_ingredient("sugar")
      expect(panna_cotta.ingredients).to include("milk")
      expect(panna_cotta.ingredients).to include("sugar")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      expect(panna_cotta.ingredients).to receive(:shuffle!)
      panna_cotta.mix!
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      expect(panna_cotta.quantity).to eq(3)
      panna_cotta.eat(2)
      expect(panna_cotta.quantity).to eq(1)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { panna_cotta.eat(5) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(chef).to receive(:titleize)
      panna_cotta.serve
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(panna_cotta)
      panna_cotta.make_more
    end
  end
end
