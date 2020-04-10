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
          cursor_color = @cursor.selected ? :red : :blue
          print "[".colorize(cursor_color) + "#{piece}".colorize(piece.color) + "] ".colorize(cursor_color)
        else 
          print "[" + "#{piece}".colorize(piece.color) + "] "
        end
      end

      print "\n"
    end

    nil
  end
end
