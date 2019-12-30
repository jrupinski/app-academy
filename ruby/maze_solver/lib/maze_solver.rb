class MazeSolver
  def initialize(filename)
    @filename = filename
    @maze_array = File.foreach(filename).map { |line| line.chomp }
  end
end

if $PROGRAM_NAME == __FILE__
  filename = ARGV[0] || "maze1.txt"
  test_solver = MazeSolver.new(filename)
  test_solver.solve
end