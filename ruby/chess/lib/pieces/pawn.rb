require_relative "piece"

class Pawn < Piece

  #
  # Return Pawn's moves 
  #
  # @return [Array] Array of possible positions
  #
  def moves
    forward_steps + side_attacks
  end

  def symbol
    "♟"
  end

  private

  #
  # Check if Pawn is in starting position
  #
  # @return [Boolean] True if Pawn on given color's starting pos
  #
  def at_start_row?
    row, col = pos
    start_row = (color == :white) ? 6 : 1

    row == start_row
  end

  #
  # Determine which way should a Pawn go to move forward (based on color/position)
  #
  # @return [Integer] Number to add to row of Pawn to move forward 
  #
  def forward_dir
    color == :white ? -1 : 1
  end

  #
  # Return possible moves in forward direction based on placement of Pawn and enemies
  #
  # @return [Array] Array of possible moves
  #
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

  #
  # Return possible moves/attacks on sides - only applicable if enemies are in front
  #
  # @return [Array] Array of possible attacks
  #
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