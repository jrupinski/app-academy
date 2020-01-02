require "byebug"

class MazeSolver
  def initialize(filename)
    @filename = filename
    @maze_array = File.foreach(filename).map { |line| line.chomp }
    @start = nil
    @end = nil
    
    @maze_array.each_with_index do |line, row|
      line.chars.each_with_index do |ele, col|
        @start = [row, col] if ele == "S"
        @end = [row, col] if ele == "E"
      end
    end
    
    @current_pos = @start
  end

  def solve
  # TODO
end

  private

  attr_reader :current_pos, :maze_array

  def go_up
    current_pos[0] -= 1
    place_mark
  end

  def go_down
    current_pos[0] += 1
    place_mark
  end

  def go_left
    current_pos[1] -= 1
    place_mark
  end

  def go_right
    current_pos[1] += 1
    place_mark
  end

  def place_mark
    row = current_pos.first
    col = current_pos.last
    maze_array[row][col] = "X"
    puts maze_array
  end
end

if $PROGRAM_NAME == __FILE__
  filename = ARGV[0] || "maze1.txt"
  test_solver = MazeSolver.new(filename)
  test_solver.solve
end