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

  #
  # Is Piece empty? (Only true on NullPiece)
  #
  # @return [Boolean] True if given Piece is empty(position is a NullPiece)
  #
  def empty?
    false
  end

  def to_s
    " #{symbol} "
  end

  #
  # Formats output in terminal nicely
  #
  def inspect
    "#{symbol}, color: #{color}, position: #{pos}"
  end

  def symbol
    # implemented by class's children
    raise NotImplementedError
  end

  def valid_moves
    self.moves.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(end_pos)
    after_move = board.dup
    after_move.move_piece(self.pos, end_pos)
    after_move.in_check?(self.color)
  end
end