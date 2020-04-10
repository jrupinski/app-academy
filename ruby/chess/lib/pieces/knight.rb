require_relative "piece"
require_relative "stepable"

class Knight < Piece
  include Stepable

  def symbol
    "♞"
  end

  protected

  def move_diffs
    [-2, 2].product([-1, 1])
  end
end