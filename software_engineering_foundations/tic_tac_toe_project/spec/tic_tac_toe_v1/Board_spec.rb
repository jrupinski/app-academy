# Test suite for Tic Tac Toe ver. 1
require "tic_tac_toe_v1/Board.rb"

describe "Board v1" do  
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
      expect { test.place_mark(0, 1, :Y) }.to raise_error(Board::AlreadyMarkedError)
      expect { test.place_mark(3, 5, :Y) }.to raise_error(Board::InvalidCoordinatesError)
      expect { test.place_mark(-1, -1, :Y) }.to raise_error(Board::InvalidCoordinatesError)
    end
  end

  context "win conditions" do
    test_board = Board.new

    let (:win_vert) { [
      [:X, "_", "_"], 
      [:X, "_", "_"], 
      [:X, "_", ":_"]
    ] }

    let (:win_hor) { [
      [:X, "_", "_"], 
      [:X, "_", "_"], 
      [:X, "_", ":_"]
    ] }

    let (:win_diagonal) { [
      [:X, "_", "_"], 
      ["_", :X, "_"], 
      ["_", "_", :X]
    ] }

    let (:win_diagonal_right) { [
      ["_", "_", :X], 
      ["_", :X, "_"], 
      [:X, "_", "_"]
    ] }

    describe "win_col?" do
      it "returns true if board has a column filled with given mark" do
        test_board.instance_variable_set(:@grid, win_vert)
        expect(test_board.win_col?(:X)).to eq(true)
      end
    end

    describe "win_row?" do
      it "returns true if board has a row filled with given mark" do
        test_board.instance_variable_set(:@grid, win_hor)
        expect(test_board.win_row?(:X)).to eq(true)
      end
    end

    describe "win_diagonal?" do
      it "returns true if board has a diagonal filled with given mark" do
        test_board.instance_variable_set(:@grid, win_diagonal)
        expect(test_board.win_diagonal?(:X)).to eq(true)
        
        test_board.instance_variable_set(:@grid, win_diagonal_right)
        expect(test_board.win_diagonal?(:X)).to eq(true)
      end
    end
  end

  describe "empty_positions?" do
    test_board = Board.new

    let (:full) { [
      [:X, :X, :Y], 
      [:Y, :Y, :X], 
      [:X, :Y, :X]
    ] }

    it "returns true if there are any empty positions left to mark" do
      expect(test_board.empty_positions?).to eq(true)

      test_board.instance_variable_set(:@grid, full)
      expect(test_board.empty_positions?).to eq(false)
    end
  end
end
