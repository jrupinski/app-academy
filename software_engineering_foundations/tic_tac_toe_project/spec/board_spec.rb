# Test suite for Tic Tac Toe ver. 1
require "board.rb"

describe Board do  
  describe "#initialize" do
    let (:board_template) { [
      ["_", "_", "_"], 
      ["_", "_", "_"], 
      ["_", "_", "_"]
    ] }
    
    it "generates a 3x3 game board" do
        expect { Board.new }.to_not raise_error
        expect(Board.new.grid).to eq(board_template)
    end
  end

  describe "valid?" do
    it "returns true if board position is within board bounds" do
      board = Board.new
      expect(board.valid?(0, 0)).to eq(true)
      expect(board.valid?(1, 1)).to eq(true)
      expect(board.valid?(0, 2)).to eq(true)
      expect(board.valid?(0, 3)).to eq(false)
      expect(board.valid?(-1, 0)).to eq(false)
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
      expect(test.place_mark(3, 5, :Y)).to eq(false)
      expect(test.place_mark(-1, -1, :Y)).to eq(false)
    end
  end

  describe "game_over" do
    let (:win_vert) { [
      [":X", "_", "_"], 
      [":X", "_", "_"], 
      [":X", "_", ":_"]
    ] }

    let (:win_hor) { [
      [":X", "_", "_"], 
      [":X", "_", "_"], 
      [":X", "_", ":_"]
    ] }

    let (:win_diagonal) { [
      [":X", "_", "_"], 
      ["_", ":X", "_"], 
      ["_", "_", ":X"]
    ] }

    let (:win_diagonal_right) { [
      ["_", "_", ":X"], 
      ["_", ":X", "_"], 
      [":X", "_", "_"]
    ] }

    let (:full) { [
      [":X", ":X", ":Y"], 
      [":Y", ":Y", ":X"], 
      [":X", ":Y", ":X"]
    ] }

    it "returns true if board is full or one of players has won" do
      test_board = Board.new
      
      test_board.instance_variable_set(:@grid, win_hor)
      expect(test_board.game_over?).to eq(true)
      
      test_board.instance_variable_set(:@grid, win_vert)
      expect(test_board.game_over?).to eq(true)
      
      test_board.instance_variable_set(:@grid, win_diagonal)
      expect(test_board.game_over?).to eq(true)
      
      test_board.instance_variable_set(:@grid, win_diagonal_right)
      expect(test_board.game_over?).to eq(true)

      expect(Board.new.game_over?).to eq(false)
    end
  end
end