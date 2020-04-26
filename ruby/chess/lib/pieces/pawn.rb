require_relative "piece"

class Pawn < Piece

  #
  # Return Pawn's moves 
  #
  # @return [Array] Array of possible positions
  #
  def moves
    @passed_end_row = true if at_end_row?
    forward_steps + side_attacks
  end

  def symbol
    "♟"
  end

  def promote(ai_playing = false)
    if ai_playing
        selection = "QKRB".chars.sample
        promote_pawn(selection)
        return
    end

    begin
      system "clear"
      puts "Pawn promoted! Which Piece to promote to? (input first letter):"
      print "Q - Queen \nK - Knight \nR - Rook \nB - Bishop\n"
      print "Make a selection: >"

      selection = STDIN.gets.chomp.upcase

      raise "Undefined selection, retry...\n\n" unless "QKRB".chars.include?(selection)
    rescue => exception
      puts exception.message
      sleep 1.5
      retry
    end

    promote_pawn(selection)
  end

  def at_end_row?
    row, col = pos
    end_row = (color == :white) ? 0 : 7

    row == end_row
  end

  private

  @passed_end_row = false

  def promote_pawn(selection)
    case selection
    when "Q"
      board[pos] = Queen.new(pos, board, color)
    when "K"
      board[pos] = Knight.new(pos, board, color)
    when "R"
      board[pos] = Rook.new(pos, board, color)
    when "B"
      board[pos] = Bishop.new(pos, board, color)
    end
  end

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