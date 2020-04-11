
#
# Piece on chess board
# Parent piece of all pieces in chess
#
class Piece
  attr_reader :board, :color
  attr_accessor :pos

  def initialize(pos, board, color)
    raise "invalid pos" unless board.valid_pos?(pos)
    raise "invalid color" unless %i[black white].include?(color)

    @pos = pos
    @board = board
    @color = color
  end

  def empty?
    false
  end

  def to_s
    " #{symbol} "
  end

  # formats output in terminal nicely
  def inspect
    "#{symbol}, color: #{color}, position: #{pos}"
  end

  def symbol
    # implemented by class's children
    raise NotImplementedError
  end

  def valid_moves
    # TODO 
  end
end