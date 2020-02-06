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

  describe "#add_numbers(nums_array)" do
    it "Accepts a number array as an argument" do
      expect { Homework.add_numbers([1,2,3]) }.to_not raise_error
    end

    it "Returns the sum of those numbers" do
      expect(Homework.add_numbers([1,2,3,4])).to eq(10)
      expect(Homework.add_numbers([3])).to eq(3)
      expect(Homework.add_numbers([-80,34,7])).to eq(-39)
      expect(Homework.add_numbers([])).to eq(nil)
    end
  end

  describe "gamma_function" do
    it "Accepts an integer as an argument" do
      expect { Homework.gamma_function }.to_not raise_error
    end

    it "Solves Gamma Function recursively" do
      expect(Homework.gamma_function(0)).to eq(nil)
      expect(Homework.gamma_function(1)).to eq(1)
      expect(Homework.gamma_function(4)).to eq(6)
      expect(Homework.gamma_function(8)).to eq(5040)
    end
  end
end