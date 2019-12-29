class MazeSolver
  def initialize(maze_file)
    @maze_array = File.foreach(maze_file).map { |line| line.chomp }
  end
end