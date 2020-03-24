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
    # place kings, bishops etc.
    [0, 1, -1, -2].each { |row| @rows[row].map! { Piece.new } }
  end

  def move_piece(start_pos, end_pos)
    start_row, start_col = start_pos
    end_row, end_col = end_pos

    if [start_row, start_col].any? { |pos| pos >= rows.size || pos < 0 } || rows[start_row][start_col].nil?
      raise ArgumentError.new("No piece at starting position!")
    elsif [end_row, end_col].any? { |pos| pos >= rows.size || pos < 0 } || !rows[end_row][end_col].nil?
      raise ArgumentError.new("Cannot move to end position!")
    end

    debugger
    rows[start_row][start_col], rows[end_row][end_col] = rows[end_row][end_col], rows[start_row][start_col]
  end
end