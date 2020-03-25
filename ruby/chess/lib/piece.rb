
#
# Piece on chess board
# Parent piece of all pieces in chess
#
class Piece
  attr_reader :board
  attr_accessor :pos

  def initialize(pos, board)
    @pos = pos
    @board = board
  end

end