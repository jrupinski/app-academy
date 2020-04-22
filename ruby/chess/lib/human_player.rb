require_relative "display"

class HumanPlayer
  attr_reader :color, :display
  def initialize(color, display)
    @color = color
    @display = display
  end

  #
  # Get input which piece to move on ChessBoard
  # Render the board and make user choose pieces in a GUI
  #
  # @return [Array] Start and End positions of a Piece
  #
  def make_move
    cursor = display.cursor
    start_pos = nil
    end_pos = nil
    
    until start_pos && end_pos
      @display.render
      
      unless start_pos
        puts "#{color}'s turn. Move from where?"
        start_pos = cursor.get_input
      else
        puts "#{color}'s turn. Move to where?"
        end_pos = cursor.get_input
      end

      display.reset!
    end

    [start_pos, end_pos]
  end
end