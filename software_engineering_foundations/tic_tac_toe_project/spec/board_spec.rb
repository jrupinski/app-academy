# Test suite for Tic Tac Toe ver. 1
require "board.rb"

describe Board do
  let (:board_template) { [
    ["_", "_", "_"], 
    ["_", "_", "_"], 
    ["_", "_", "_"]
  ] }

  describe "#initialize" do
    it "generates a 3x3 game board" do
      expect { Board.new }.to_not raise_error
      expect(Board.new.grid).to eq(board_template)
    end
  end
  
  describe "place_mark" do
    it "allows to place player marks on board" do
      test = Board.new
      expect { test.place_mark(0, 2, :X) }.to_not raise_error
      test.place_mark(0, 1, :O)

      expect(test.grid[0][0]).to eq("_")
      expect(test.grid[0][1]).to eq(:O)
      expect(test.grid[0][2]).to eq(:X)
      expect(test.grid[3][5]).to eq(false)
      expect(test.grid[-1][-1]).to eq(false)
    end
  end
end