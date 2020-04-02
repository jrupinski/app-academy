require_relative "pieces"

require "byebug"
#
# Chess board for chess
#
class Board
  attr_reader :rows

  def initialize
    # initialize board with placeholder pieces for now
    @rows = Array.new(8) { Array.new(8, NullPiece.instance) }
    populate_chessboard
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].empty? || !valid_pos?(start_pos)
      raise ArgumentError.new("No piece at starting position!")
    elsif !self[end_pos].empty? || !valid_pos?(end_pos)
      raise ArgumentError.new("Cannot move to end position!")
    end

    # move piece
    self[end_pos] = self[start_pos] 
    self[start_pos] = NullPiece.instance
    # update piece's position
    self[end_pos].pos = end_pos
  end

  def [](pos)
    raise ArgumentError.new("Invalid position!") if !valid_pos?(pos)
    row, col = pos
    rows[row][col]
  end

  def []=(pos, val)
    raise ArgumentError.new("Invalid position!") if !valid_pos?(pos)
    row, col = pos
    rows[row][col] = val
  end 

  def valid_pos?(pos)
    pos.all? { |coor| coor < rows.size && coor >= 0 }
  end

  def populate_chessboard
    # TODO - add rest of chess pieces after implementing them
    place_pawns
  end

  def place_pawns
    pawn_rows = [1, 6]

    pawn_rows.each do |row|
      (0...8).each do |col|
        pos = [row, col]
        color = row == 1 ? :white : :black
        self[pos] = Pawn.new(pos, self, color)
      end
    end
  end
end