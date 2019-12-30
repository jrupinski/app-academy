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
  end
end

def solve
  # TODO
end

private

def go_up
  # TODO
end

def go_down
  # TODO
end

def go_left
  # TODO
end

def go_right
  # TODO
end

if $PROGRAM_NAME == __FILE__
  filename = ARGV[0] || "maze1.txt"
  test_solver = MazeSolver.new(filename)
  test_solver.solve
end