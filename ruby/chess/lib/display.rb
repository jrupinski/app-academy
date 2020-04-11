require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  #
  # Render ChessBoard in terminal
  #
  # @return [Nil]
  #
  def render
    ("A".."H").each { |col| print "     #{col}"}
    print "\n\n"

    (0...8).each do |row|
      row_idx = (7 - row) % @board.rows.count + 1
      print "#{row_idx}  "
      (0...8).each do |col|
        pos = [row, col]
        piece = @board[pos]

        if pos == @cursor.cursor_pos
          cursor_color = @cursor.selected ? :red : :blue
          print "[".colorize(cursor_color) + "#{piece}".colorize(piece.color) + "] ".colorize(cursor_color)
        else 
          print "[" + "#{piece}".colorize(piece.color) + "] "
        end
      end

      print "  #{row_idx}"
      print "\n\n"
    end

    ("A".."H").each { |col| print "     #{col}"}
    print "\n"
  end
end
