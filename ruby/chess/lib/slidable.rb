#
# Module for getting sliding pieces' valid next moves on chessboard
#
module Slidable
  private
  HORIZONTAL_DIRS = []
  VERTICAL_DIRS = []
  DIAGONAL_DIRS = []
  
  public

  def moves(*move_dirs)
    moves = []
    [HORIZONTAL_DIRS, VERTICAL_DIRS, DIAGONAL_DIRS].each(&:clear)

    update_valid_diagonals if move_dirs.include?(:diagonal)
    update_valid_horizontals if move_dirs.include?(:horizontal)
    update_valid_verticals if move_dirs.include?(:vertical)

    moves += HORIZONTAL_DIRS
    moves += VERTICAL_DIRS
    moves += DIAGONAL_DIRS

    moves
  end

  def move_dirs
    # subclass should implement it
    raise NotImplementedError
  end

  private
  def update_valid_diagonals
    piece_row, piece_col = pos

    # check diagonals of current piece idx
    deltas = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    deltas.each do |(dx, dy)|
      new_pos = piece_row, piece_col 

      0.upto(7).each do |idx|
        # update with delta
        new_pos = new_pos[0] + dx, new_pos[1] + dy
        next unless board.valid_pos?(new_pos)
        
        if board[new_pos].empty?
          DIAGONAL_DIRS << new_pos
          next
        elsif board[new_pos].color != color
          DIAGONAL_DIRS << new_pos
          break
        end

        break
      end
    end
  end

  def update_valid_verticals
    piece_row, piece_col = pos

    # check left of current piece idx
    piece_row.downto(0).each do |idx|
      new_pos = idx, piece_col

      if board[new_pos].empty?
        VERTICAL_DIRS << new_pos
      elsif board[new_pos].color != color
        VERTICAL_DIRS << new_pos
        break
      end
    end

    # check right of current piece idx
    piece_row.upto(7).each do |idx|
      new_pos = idx, piece_col

      if board[new_pos].empty?
        VERTICAL_DIRS << new_pos
      elsif board[new_pos].color != color
        VERTICAL_DIRS << new_pos
        break
      end
    end
  end

  def update_valid_horizontals
    piece_row, piece_col = pos

    # check left of current piece idx
    piece_col.downto(0).each do |idx|
      new_pos = piece_row, idx

      if board[new_pos].empty?
        HORIZONTAL_DIRS << new_pos
      elsif board[new_pos].color != color
        HORIZONTAL_DIRS << new_pos
        break
      end
    end

    # check right of current piece idx
    piece_col.upto(7).each do |idx|
      new_pos = piece_row, idx

      if board[new_pos].empty?
        HORIZONTAL_DIRS << new_pos
      elsif board[new_pos].color != color
        HORIZONTAL_DIRS << new_pos
        break
      end
    end
  end

end