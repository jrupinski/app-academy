#
# Find positions of eight queens on 8x8 grid where they don't attack each other
#
class EightQueens
  QUEEN = true

  def initialize
    @board = Array.new(8) { Array.new(8, false) }
  end

  # TODO: make this method test each possibility, not check random ones
  def get_non_conflict_positions
    until no_conflicts? && queens_positions.count == 8
      clean_board
      place_8_random_queens
    end

    print_solution
  end
  
  private 

  def no_conflicts?
    no_conflicts_vertically? && no_conflicts_horizontally? && no_conflicts_diagonally?
  end

  def print_solution
    puts "Non-conflict Queen placements found:\n #{queens_positions_formatted.inspect}\n"
    board_formatted.each { |row| row.each { |ele| print ele }; puts }
  end

  # Helper Methods

  def valid_positions
    rows = (1..8).to_a
    columns = ("a".."h").to_a
    rows.product(columns)
  end    

  def place_random_queen(row)
    random_column = (0...8).to_a.sample
    @board[row][random_column] = QUEEN
  end

  def place_8_random_queens
    (0...8).to_a.each { |row| place_random_queen(row) }
  end
  
  def no_conflicts_horizontally?
    @board.none? { |row| row.count(QUEEN) > 1 }
  end

  def no_conflicts_vertically?
    @board.transpose.none? { |column| column.count(QUEEN) > 1 }
  end

  def no_conflicts_diagonally?
    queens_positions.permutation(2).none? do |queen_1, queen_2|
      queen_1_row, queen_1_col = queen_1.first, queen_1.last
      queen_2_row, queen_2_col = queen_2.first, queen_2.last
      delta_row = (queen_1_row - queen_2_row).abs
      delta_column = (queen_1_col - queen_2_col).abs
      delta_column == delta_row
    end
  end

  def queens_positions
    positions = []
    @board.each.with_index do |line, row|
      line.each.with_index { |position, col| positions << [row, col] if position == QUEEN }
    end
    positions
  end

  def queens_positions_formatted
    rows = (1..8).to_a
    columns = ("a".."h").to_a
    queens_positions.map do |queen_pos|
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
  EightQueens.new.get_non_conflict_positions
end