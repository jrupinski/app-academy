require_relative 'tic_tac_toe'

require "byebug"
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

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

  def winning_node?(evaluator)
    # TODO
  end

  # This method generates an array of all moves that can be made after
  # the current move.
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
