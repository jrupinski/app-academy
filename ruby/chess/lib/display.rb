require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    @board.rows.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        pos = [row_idx, col_idx]
        piece = @board[pos]
        if pos == @cursor.cursor_pos
          print "[".colorize(:blue) + "#{piece}".colorize(piece.color) + "] ".colorize(:blue)
        else 
          print "[" + "#{piece}".colorize(piece.color) + "] "
        end
      end
      puts
    end

    nil
  end
end