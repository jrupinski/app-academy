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
end


if $PROGRAM_NAME == __FILE__
  a = Board.new
  b = Display.new(a, true)
  b.render
  # fastest checkmate placement, in 4 moves
  a.move_piece!([1, 5], [3, 5])
  a.move_piece!([6, 6], [4, 6])
  a.move_piece!([0, 3], [4, 7])
  puts "BEFORE MOVING INTO A CHECKMATE - should not be in check or in checkmate"
  puts "is in a check? #{a.in_check?(:white)}"
  puts "is in a checkmate? #{a.checkmate?(:white)}"
  b.render
  puts
  print "is next move a move into a check? (should be true) #{a[[6, 5]].move_into_check?([5, 5])}"
  puts 
  
  ### UNCOMMENT THIS TO PLACE WHITE IN CHECKMATE (test #checkmate?/#move_into_check?) ###
  a.move_piece([6, 5], [5, 5])
  # a.move_piece!([6, 5], [5, 5])
  # # check if in check?
  # puts "AFTER MOVING INTO CHECKMATE"
  # b.render
  # puts "is in a check? #{a.in_check?(:white)}"
  # # debugger
  # puts "is in a checkmate? #{a.checkmate?(:white)}"

  # loop do
  #   b.render
  #   b.cursor.get_input
  #   system "clear"
  # end
end