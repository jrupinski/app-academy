require_relative "piece"
require_relative "stepable"

class King < Piece
  include Stepable

  def symbol
    "♚"
  end

  protected

  def move_diffs
    [-1, 0, 1].repeated_permutation(2).to_a
  end
end