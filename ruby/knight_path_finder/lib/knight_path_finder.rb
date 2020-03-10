#
# Find the shortest path for a Chess Knight from a starting position to an end position.
# Both the start and end positions should be on a standard 8x8 chess board.
#
class KnightPathFinder
  attr_reader :root_node
  
  def initialize(starting_position)
    @board = Array.new(8) { Array.new(8) }
    @position = starting_position
    @root_node = starting_position
    @considered_positions = [starting_position]
  end

  def self.valid_moves(pos)
    # todo
  end

  #
  # Get valid moves from given position that have not been visitied/considered yet.
  #
  # @param [Array] pos Position on board
  #
  # @return [Array] Array of possible moves/positions
  #
  def new_move_positions(pos)
    new_positions = valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end
end