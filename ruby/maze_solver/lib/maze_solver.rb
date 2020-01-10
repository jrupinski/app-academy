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
      # fix heuristics
      a_star
  end

  private
  attr_reader :maze_array
  
  def go_to(node)
    @current_pos = node
  end

  def place_mark
    maze_array[current_row][current_column] = "X"
    puts maze_array
  end

  def a_star
    # Todo: Fix heuristics
    closed_list = []
    @path_scores = {}
    parent_node = @start
    loop do
      debugger
      # Starting the search
      open_list = { current_node => parent_node }
      parent_node = current_node
      open_list.delete(parent_node)

      # get current paths
      adjacent_nodes.each do |node|
        if is_empty?(node) && !closed_list.include?(node) && node != @start
          open_list[node] = parent_node 
        end
      end
        
      # Path scoring for open list
      @path_scores.merge!(current_path_scores(open_list))
      # Continuing the Search
      show_possible_moves(open_list)
      go_to(fastest_node(open_list))
      closed_list << current_node

      place_mark
    
      return true if closed_list.include?(@end)
      return false if open_list.empty?
    end
  end
  
  # helper methods
  def current_path_scores(node_list)
    path_scores = {}
    node_list.each { |node, parent_node| path_scores[node] = path_score(node, parent_node) }
    path_scores
  end

  def path_score(node, parent_node)
    g = calculate_g(node)
    unless parent_node == @start 
      parent_g_value = @path_scores[parent_node][:g]
      g += parent_g_value
      if @path_scores.include?(node)
        old_g = @path_scores[node][:g]
        return @path_scores[node] if g >= old_g
      end
    end
    h = calculate_h(node)
    f = g + h
    { f: f, g: g, h: h }
  end
  
  def fastest_node(node_list)
    node_scores = @path_scores.select { |node, score| node_list.include?(node) }
    node_scores.min_by { |node, scores| scores[:f] }.first 
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
    maze_array[row][col] != "*"
  end

  def show_possible_moves(available_node_list)
    possible_moves_maze_array = maze_array.dup
    available_node_list.keys.each { |node| possible_moves_maze_array[node.first][node.last] = "0" }
    puts possible_moves_maze_array
    available_node_list.keys.each { |node| possible_moves_maze_array[node.first][node.last] = " " }
    possible_moves_scores = @path_scores.select { |node, scores| available_node_list.include?(node) }
    possible_moves_scores.each {|node, scores| puts "#{node} : #{scores}" }
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