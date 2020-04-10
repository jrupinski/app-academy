require_relative "pieces"

require "byebug"
#
# Chess board for chess
#
class Board
  attr_reader :rows

  def initialize
    # initialize board with placeholder pieces for now
    @sentinel = NullPiece.instance
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
    self[start_pos] = sentinel
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

  private

  attr_reader :sentinel

  def populate_chessboard
    @rows = Array.new(8) { Array.new(8, sentinel) }

    (0...8).each do |row|
      (0...8).each do |col|
        pos = [row, col]
        piece = piece_at(pos)
        color = color_at(pos)

        if piece == sentinel
          self[pos] = sentinel
        else
          self[pos] = piece.new(pos, self, color)
        end
      end
    end
  end

  def piece_at(pos)
    row, col = pos
    if row == 1 || row == 6
      return Pawn
    elsif row != 0 && row !=7 
      return sentinel
    end

    case col
    when 0, 7
      Rook
    when 1, 6
      Knight
    when 2, 5
      Bishop
    when 3
      Queen
    when 4
      King
    end
  end

  def color_at(pos)
    row, col = pos
    (row == 0 || row == 1) ? :white : :black
  end

end