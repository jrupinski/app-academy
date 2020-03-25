require_relative "piece"

require "byebug"
#
# Chess board for chess
#
class Board
  attr_reader :rows

  def initialize
    # initialize board with placeholder pieces for now
    @rows = Array.new(8) { Array.new(8, nil) }
    # place pieces on both sides' two first rows
    white_rows, black_rows = [0, 1], [6, 7]

    [*white_rows, *black_rows].each do |row|
      (0...8).each do |col|
        pos = [row, col]
        color = white_rows.include?(row) ? "white" : "black"
        self[pos] = Piece.new(pos, self, color)
      end
    end
  end

  def move_piece(start_pos, end_pos)
    if empty?(start_pos) || !valid_pos?(start_pos)
      raise ArgumentError.new("No piece at starting position!")
    elsif !empty?(end_pos) || !valid_pos?(end_pos)
      raise ArgumentError.new("Cannot move to end position!")
    end

    # move piece
    self[end_pos] = self[start_pos] 
    self[start_pos] = nil
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

  def empty?(pos)
    self[pos].nil?
  end
end