class AiPlayer < Player

  def make_move
    # take a random valid piece
    piece = movable_pieces.sample
    start_pos = piece.pos
    # take a random valid move 
    end_pos = piece.valid_moves.sample
    puts "#{color} player: Moving #{piece} at #{start_pos} to #{end_pos}"
    sleep 2
    [start_pos, end_pos]
  end
  
  private
  
  def available_pieces
    @board = self.display.cursor.board
    @board.pieces.select { |piece| piece.color == self.color }
  end

  def movable_pieces
    available_pieces.reject { |piece| piece.valid_moves.empty? }
  end
end