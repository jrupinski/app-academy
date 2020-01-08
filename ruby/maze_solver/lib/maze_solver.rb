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
      a_star
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
    debugger
    # Starting the search
    parent_node = current_node
    open_list = { parent_node => parent_node }
    adjacent_nodes.each { |node| open_list[node] = parent_node if is_empty?(node) }
    open_list.delete(parent_node)
    closed_list = parent_node
    # Path scoring for open list
    path_scores = {}
    open_list.each { |node, parent_node| path_scores[node] = path_score(node) }
    # Continuing the Search
    # TODO

  end


  # helper methods
  def path_score(node)
      g = calculate_g(node)
      h = calculate_h(node)
      f = g + h
      { f: f, g: g, h: h }
  end

  # G - distance from starting point - 10 points for each square, 14 for diagonal
  def calculate_g(node)
    node_row, node_column = node.first, node.last
    start_row, start_column = @start.first, @start.last

    vertical_distance = (start_row - node_row).abs 
    horizontal_distance = (start_column - node_column).abs
    diagonal_distance = [vertical_distance, horizontal_distance].min
    # recalculate how many squares are left after diagonals
    unless diagonal_distance == 0
      horizontal_distance %= diagonal_distance
      vertical_distance %= diagonal_distance
    end
    # calculate G
    diagonal_distance * 14 + (vertical_distance + horizontal_distance) * 10
  end

  # H - distance to end point, based on Manhattan method (literal straight distance)
  def calculate_h(node)
    node_row, node_column = node.first, node.last
    end_row, end_column = @end.first, @end.last

    vertical_distance = (end_row - node_row).abs 
    horizontal_distance = (end_column - node_column).abs

    (vertical_distance + horizontal_distance) * 10
  end

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