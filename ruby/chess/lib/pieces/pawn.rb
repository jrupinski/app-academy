require_relative "piece"

class Pawn < Piece

  def moves
    forward_steps + side_attacks
  end

  def symbol
    "♟"
  end

  private

  def at_start_row?
    row, col = pos
    start_row = (color == :white) ? 1 : 6

    row == start_row
  end

  def forward_dir
    color == :white ? -1 : 1
  end

  def forward_steps
    forward_steps = []
    row, col = pos
    next_pos = pos.dup
    num_of_steps = (at_start_row? ? 2 : 1)

    num_of_steps.times do
      next_pos[0] += forward_dir
      break unless board.valid_pos?(next_pos) && board[next_pos].empty?
      forward_steps << next_pos.dup
    end

    forward_steps
  end

  def side_attacks
    side_attacks = []
    row, col = pos

    sides = [-1, 1]
    sides.each do |side|
      side_pos = row + forward_dir, col + side
      next unless board.valid_pos?(side_pos)

      if board[side_pos].color == color || board[side_pos].empty?
        next
      else
        side_attacks << side_pos 
      end
    end

    side_attacks
  end
end