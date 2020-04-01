module Steppable
  def moves
    valid_moves = []
    cur_x, cur_y = pos

    move_diffs.each do |(diff_x, diff_y)|
      new_pos = [cur_x + diff_x, cur_y + diff_y]
      next unless board.valid_pos?(new_pos)

      if board[new_pos].empty?
        valid_moves << new_pos 
      elsif board[new_pos].color != color
        valid_moves << new_pos 
      end
    end

    valid_moves
  end

  def move_diffs
    # subclasses implement it
    raise NotImplementedError
  end
end