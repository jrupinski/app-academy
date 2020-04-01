
#
# Piece on chess board
# Parent piece of all pieces in chess
#
class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def empty?
    false
  end
end