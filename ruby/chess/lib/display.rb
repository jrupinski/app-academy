require "colorize"
require_relative "cursor"
require_relative "board"

class Display
  attr_reader :cursor

  def initialize(board, debug_mode = false)
    @board = board
    @cursor = Cursor.new([0, 0], board)
    @debug = debug_mode
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

    if @debug
      cursor_pos = @cursor.cursor_pos
      selected_piece = @board[cursor_pos]
      enemy_color = (selected_piece.color == :white) ? :black : :white
      puts "selected piece: #{selected_piece.symbol}, position: #{cursor_pos}"
      puts "selected piece's available moves:"
      puts "#{selected_piece.valid_moves}".colorize(:yellow)
      puts "Selected color in check?: #{@board.in_check?(enemy_color)}"
      puts "Moves that will result in selected color's check: #{selected_piece.moves.select { |pos| selected_piece.move_into_check?(pos) }}"
    end
  end

  def reset!
    system "clear"
  end
end
