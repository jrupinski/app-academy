require_relative "polytree_node"

#
# Find the shortest path for a Chess Knight from a starting position to an end position.
# Both the start and end positions should be on a standard 8x8 chess board.
#
class KnightPathFinder

  MOVES = [
    [-2, 1],
    [-2, -1],
    [2, 1],
    [2, -1],
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2]
  ].freeze

  def initialize(start_pos)
    @start_pos = start_pos
    @considered_positions = [start_pos]
    build_move_tree
  end

  #
  # Find a path from starting Chess Knight position to given position on Chess Board
  #
  # @param [Array] end_pos Row and column of position on destination Board
  #
  # @return [Array] Path to take starting from start position to destination 
  #
  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)
    trace_path_back(end_node)
      .reverse
      .map(&:value)
  end

  #
  # Get all valid chess knight moves from given position
  #
  # @param [Array] pos Chess knight position on board
  #
  # @return [Array] Valid moves for Chess knight to make
  #
  def self.valid_moves(pos)
    valid_moves = []
    
    cur_x, cur_y = pos
    MOVES.each do |(dx, dy)|
      new_pos = [cur_x + dx, cur_y + dy]
      if new_pos.all?{ |coord| coord.between?(0, 7) } # chess board is 8x8
        valid_moves << new_pos
      end
    end

    valid_moves
  end

  private_constant :MOVES
  private

  attr_accessor :root_node

  #
  # Get valid moves from given position that have not been visitied/considered yet.
  #
  # @param [Array] pos Position on board
  #
  # @return [Array] Array of possible moves/positions
  #
  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos) - @considered_positions
    @considered_positions += new_positions
    new_positions
  end

  #
  # Build a move tree in a breadth-first manner
  #
  def build_move_tree
    self.root_node = PolyTreeNode.new(@start_pos)

    nodes = [root_node]
    until nodes.empty?
      current_node = nodes.shift
      current_pos = current_node.value

      new_move_positions(current_pos).each do |pos|
        next_node = PolyTreeNode.new(pos)
        current_node.add_child(next_node)
        nodes << next_node
      end
    end
  end

  #
  # Trace node path from end node to root node
  #
  # @param [Node] end_node End node
  #
  # @return [Array] Array of nodes that create a path from end to root node
  #
  def trace_path_back(end_node)
    path = []

    current_node = end_node
    until current_node.nil?
      path << current_node
      current_node = current_node.parent
    end

    path
  end
end

if $PROGRAM_NAME == __FILE__
  kpf = KnightPathFinder.new([0, 0])
  p kpf.find_path([6, 2])
end