require "byebug"

class MazeSolver
  def initialize(filename)
    @filename = filename
    @maze_array = File.foreach(filename).map { |line| line.chomp }

    @maze_array.each_with_index do |line, row|
      line.chars.each_with_index do |ele, col|
        @start = [row, col] if ele == "S"
        @end = [row, col] if ele == "E"
      end
    end
    
    @current_pos = @start
  end

  def solve
    # TODO: FIX THIS, DOES NOT WORK
    loop do
      go_up until go_up == false
      go_right until go_right == false
      go_down until go_down == false
      go_left until go_left == false
      break if current_neighbours.none? { |neighbour| is_empty?(neighbour) }
    end
  end

  private

  attr_reader :maze_array

  def go_up
    space_up = [current_row - 1, current_column]
    return false if !is_empty?(space_up)
    @current_pos = space_up
    place_mark
    true
  end

  def go_down
    space_down = [current_row + 1, current_column]
    return false if !is_empty?(space_down)
    @current_pos = space_down
    place_mark
    true
  end

  def go_left
    space_left = [current_row, current_column - 1]
    return false if !is_empty?(space_left)
    @current_pos = space_left
    place_mark
    true
  end

  def go_right
    space_right = [current_row, current_column + 1]
    return false if !is_empty?(space_right)
    @current_pos = space_right
    place_mark
    true
  end
  
  def place_mark
    maze_array[current_row][current_column] = "X"
    puts maze_array
  end

  # helper methods
  def is_empty?(place)
    row, col = place.first, place.last
    maze_array[row][col] == " "
  end

  def current_row
    @current_pos.first
  end

  def current_column
    @current_pos.last
  end

  def current_neighbours
    neighbours = []
    [-1, 1].each do |row|
      [-1, 1].each do |col|
        neighbours << [current_row + row, current_column + col]
      end
    end

    neighbours
  end
end


if $PROGRAM_NAME == __FILE__
  filename = ARGV[0] || "maze1.txt"
  test_solver = MazeSolver.new(filename)
  test_solver.solve
end