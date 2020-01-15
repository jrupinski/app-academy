require "set"
#
# Find positions of eight queens on NxN grid where they don't attack each other
#
class EightQueens
  QUEEN = true

  def initialize(n)
    @checked_combinations = Set.new
    @n = n
    @board = Array.new(n) { Array.new(n, false) }
  end

  def get_non_conflict_positions
    # check every combination
    loop do
      check_next_combination
      @checked_combinations.add(current_queens_positions)
      no_conflicts? ? break : clean_board
    end
    
    print_solution
  end
  
  private 
  
  def check_next_combination
    (0...@n).each do |row|
      (0...@n).each do |column|
        @board[row][column] = QUEEN  
        break unless @checked_combinations.include?(current_queens_positions)
        clear_position([row, column])
      end
    end
  end

  def no_conflicts?
    no_conflicts_vertically? && no_conflicts_horizontally? && no_conflicts_diagonally?
  end
  
  def print_solution
    puts "Non-conflict Queen placements found:\n #{queens_positions_formatted.inspect}\n"
    board_formatted.each { |row| row.each { |ele| print ele }; puts }
  end
    
  # Helper Methods
    
  def clear_position(position)
    row, column = position.first, position.last
    @board[row][column] = false 
  end

  def place_random_queen(row)
    random_column = (0...@n).to_a.sample
    @board[row][random_column] = QUEEN
  end

  def place_N_random_queens
    (0...@n).to_a.each { |row| place_random_queen(row) }
  end
  
  def no_conflicts_horizontally?
    @board.none? { |row| row.count(QUEEN) > 1 }
  end

  def no_conflicts_vertically?
    @board.transpose.none? { |column| column.count(QUEEN) > 1 }
  end

  def no_conflicts_diagonally?
    current_queens_positions.permutation(2).none? do |queen_1, queen_2|
      queen_1_row, queen_1_col = queen_1.first, queen_1.last
      queen_2_row, queen_2_col = queen_2.first, queen_2.last
      delta_row = (queen_1_row - queen_2_row).abs
      delta_column = (queen_1_col - queen_2_col).abs
      delta_column == delta_row
    end
  end

  def current_queens_positions
    positions = []
    @board.each.with_index do |line, row|
      line.each.with_index { |position, col| positions << [row, col] if position == QUEEN }
    end
    positions
  end

  def queens_positions_formatted
    rows = (1..@n).to_a
    columns = ("a".."h").to_a
    current_queens_positions.map do |queen_pos|
      queen_row, queen_column = queen_pos.first, queen_pos.last
      [rows[queen_row], columns[queen_column]] 
    end
  end

  def board_formatted
    @board.map { |row| row.map { |ele| ele == QUEEN ? "[Q]" : "[ ]"} }
  end

  def clean_board
    @board.map { |row| row.fill(false) }
  end
end

if $PROGRAM_NAME == __FILE__
  # default - 4x4 board - because it's way faster to check. uncomment to check 8x8 board
  EightQueens.new(4).get_non_conflict_positions
  # EightQueens.new(8).get_non_conflict_positions
end