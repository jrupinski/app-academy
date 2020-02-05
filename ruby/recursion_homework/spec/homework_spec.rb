require "homework.rb"

describe "homework" do
  describe "#sum_to" do
    it "Accepts a number as an argument" do
      expect { Homework.sum_to(5) }.to_not raise_error
    end

    it "Uses recursion to calculate the sum from 1 to n" do
      # Test Cases
      expect(Homework.sum_to(5)).to eq(15)
      expect(Homework.sum_to(1)).to eq(1)
      expect(Homework.sum_to(9)).to eq(45)
      expect(Homework.sum_to(-8)).to eq(nil)
    end
  end
end