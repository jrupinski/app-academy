#
# Module for getting sliding pieces' valid next moves on chessboard
#
module Slideable
  HORIZONTAL_AND_VERTICAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ].freeze

  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ].freeze
  
  def horizontal_and_vertical_dirs
    HORIZONTAL_AND_VERTICAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    moves = []
    
    move_dirs.each do |dx, dy|
      moves += valid_moves_in_dir(dx, dy)
    end

    moves
  end
  
  private

  def move_dirs
    # subclass should implement it
    raise NotImplementedError
  end

  def valid_moves_in_dir(dx, dy)
    cur_row, cur_col = pos
    moves = []

      loop do
        cur_row = cur_row + dx
        cur_col = cur_col + dy 
        new_pos = [cur_row, cur_col]

        break unless board.valid_pos?(new_pos)

        if board[new_pos].empty?
          moves << new_pos
        else
        # take over enemy piece
        moves << new_pos if board[new_pos].color != self.color

        # can't move past blocking piece
        break
      end
    end

    moves
  end
end