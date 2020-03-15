require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  #
  # Check if node is a losing node (if this move will end up in given player losing)
  # If it's player's turn - check if all possible moves will end up in losing
  # If it's opponent's turn - check if any of his moves will end up in player losing
  #
  # @param [Symbol] evaluator Symbol of player
  #
  # @return [Boolean] Is this node a losing node for player
  #
  def losing_node?(evaluator)
    if board.over?
      return board.won? && board.winner != evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.all? { |node| node.losing_node?(evaluator) }
    else
      self.children.any? { |node| node.losing_node?(evaluator) }
    end
  end

  #
  # Check if node is a winning node (if this move is a winning move)
  # If it's player's turn - check if there's any winning moves possible
  # If it's opponent's turn - check if all his moves will end up in player winning
  #
  # @param [Symbol] evaluator Symbol of player
  #
  # @return [Boolean] Is this node a winning node for player
  #
  def winning_node?(evaluator)
    if board.over?
      return board.won? && board.winner == evaluator
    end

    if self.next_mover_mark == evaluator
      self.children.any? { |node| node.winning_node?(evaluator) }
    else
      self.children.all? { |node| node.winning_node?(evaluator) }
    end
  end

  #
  # Generate an array of possible moves one turn ahead
  #
  # @return [Array] Array of Nodes (possible moves)
  #
  def children
    children = []
  
    (0...board.rows.count).each do |row|
      (0...board.rows.count).each do |col|
        pos = [row, col]
        opposite_mark = self.next_mover_mark == :x ? :o : :x

        if board.empty?(pos)
          board_after_move = board.dup
          board_after_move[pos] = self.next_mover_mark
          next_node = TicTacToeNode.new(board_after_move, opposite_mark, pos)

          children << next_node
        end
      end
    end
  
    children
  end
end
