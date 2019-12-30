require "maze_solver"

describe MazeSolver do
  let(:maze_solver) { MazeSolver.new }
  let(:maze_file) { "spec/maze1.txt" }
  let(:solved_maze) { "spec/maze1_solution.txt" }

  it "Creates a new Maze Solver object" do
    expect { MazeSolver.new(maze_file) }.to_not raise_error
  end

  it "Returns a solved maze" do
    maze_solver = MazeSolver.new(maze_file)
    expect(maze_solver.solve).to eq(solved_maze)
  end
end