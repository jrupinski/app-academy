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

  #
  # Print Piece's symbol
  #
  # @return [String] Symbol of Piece
  #
  def to_s
    " #{symbol} "
  end

  #
  # Return Piece's symbol
  #
  # @return [String] Piece's symbol
  #
  def symbol
    # implemented by class's children
    raise NotImplementedError
  end

  #
  # Return moves that will NOT result in a check on a Board
  #
  # @return [Array] Array of valid moves
  #
  def valid_moves
    self.moves.reject { |pos| move_into_check?(pos) }
  end

  private

  #
  # Check if moving into given position result in a check against player's color 
  #
  # @param [Array] end_pos Position to move Piece to
  #
  # @return [Boolean] True if move will end up in a check
  #
  def move_into_check?(end_pos)
    after_move = board.dup
    after_move.move_piece!(self.pos, end_pos)
    after_move.in_check?(self.color)
  end
end