require "byebug"
require "set"

class MazeSolver
  def initialize(filename)
    @filename = filename
    @maze_array = File.open(filename).map.with_index do |line, row|
      @start = [row, line.index("S")] if line.include?("S")
      @end = [row, line.index("E")] if line.include?("E")
      line.chomp
    end
    @current_pos = @start
  end

  def solve
    # TODO: FIX THIS, DOES NOT WORK
    loop do
      place_mark until go_up == false
      place_mark until go_right == false
      place_mark until go_down == false
      place_mark until go_left == false
      break if adjacent_nodes.to_a.none? { |node| is_empty?(node) }
    end
  end

  private

  attr_reader :maze_array

  def go_up
    node_up = [current_row - 1, current_column]
    return false if !is_empty?(node_up)
    @current_pos = node_up
    true
  end

  def go_down
    node_down = [current_row + 1, current_column]
    return false if !is_empty?(node_down)
    @current_pos = node_down
    true
  end

  def go_left
    node_left = [current_row, current_column - 1]
    return false if !is_empty?(node_left)
    @current_pos = node_left
    true
  end

  def go_right
    node_right = [current_row, current_column + 1]
    return false if !is_empty?(node_right)
    @current_pos = node_right
    true
  end
  
  def place_mark
    maze_array[current_row][current_column] = "X"
    puts maze_array
  end

  def a_star
    # TODO: complete the rest of this method
    parent_node = current_node
    open_list = Set[parent_node]
    adjacent_nodes.to_a.each { |node| open_list.add({parent_node => node}) if is_empty?(node) }
    open_list.delete(parent_node)
    closed_list = parent_node
  end


  # helper methods
  def is_empty?(node)
    row, col = node.first, node.last
    maze_array[row][col] == " "
  end

  def current_node
    [current_row, current_column]
  end

  def current_row
    @current_pos.first
  end

  def current_column
    @current_pos.last
  end

  def adjacent_nodes
    nodes = Set.new
    (-1..1).each do |row|
      (-1..1).each do |col|
        adjacent_node = [current_row + row, current_column + col]
        nodes << adjacent_node if !nodes.include?(adjacent_node)
      end
    end

    nodes
  end
end


if $PROGRAM_NAME == __FILE__
  filename = ARGV[0] || "maze1.txt"
  test_solver = MazeSolver.new(filename)
  test_solver.solve
end