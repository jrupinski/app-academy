require "byebug"
require "set"

#
# Solver for text maze files. It solves maze1.txt file by default.
# Takes maze file as parameter
#
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
    raise "no start or end node!" if [@end, @start].any?(&:nil?)
    a_star
  end

  private
  attr_reader :maze_array
  
  def go_to(node)
    @current_pos = node
  end

  def place_mark
    maze_array[current_row][current_column] = "X"
  end

  
  # helper methods
  def a_star
    @closed_list = []
    @path_scores = {}
    @open_list = { @start => @start }
    loop do
      # Starting the search
      parent_node = current_node
      # get current paths
      current_paths = {}
      adjacent_nodes.each do |node|
        if in_bounds?(node) && is_empty?(node) && !@closed_list.include?(node) && node != @start
          @open_list[node] = parent_node 
          current_paths[node] = parent_node
        end
      end

      # no more paths on current path - start from another node
      if current_paths.empty? && @open_list.count > 1
        go_to(@start)
        clean_marks
        next
      end
      
      # Path scoring for possible paths
      # update nodes only if G from current node is less than from it's parent 
      current_paths_scores = path_scores(current_paths)
      best_nodes = current_paths.reject do |node|
        
        if @path_scores.include?(node)
          current_paths_scores[node][:g] >= @path_scores[node][:g]
        end
      end

      # prioritize new nodes and old nodes with better G going from current node
      current_paths = best_nodes if !best_nodes.empty?
      
      @path_scores.merge!(path_scores(current_paths))
      
      # Continuing the Search
      best_node = fastest_node(current_paths)
      @closed_list << best_node
      @open_list.delete(best_node)
      go_to(best_node)
      
      place_mark unless [@start, @end].include?(current_node) 
      
      if path_found?
        print_path
        return true
      elsif no_paths_left?
        puts "No path to exit found"
        return false
      end
    end
  end

  def in_bounds?(node)
    maze_rows, maze_columns = maze_array.length, maze_array.max.length
    node_row, node_column = node.first, node.last
    maze_rows > node_row && maze_columns > node_column
  end

  def path_found?
    @closed_list.include?(@end)
  end

  def no_paths_left?
    @open_list.one? || adjacent_nodes.all? { |node| @closed_list.include?(node) } # starting node only?
  end
    

  def print_path
    puts "Path found!"
    puts maze_array
  end

  def path_scores(node_list)
    path_scores = {}
    node_list.each { |node, parent_node| path_scores[node] = node_score(node, parent_node) }
    path_scores
  end
  
  def node_score(node, parent_node)
    g = calculate_g(node, parent_node)
    unless parent_node == @start 
      parent_g_value = @path_scores[parent_node][:g]
      g += parent_g_value
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
  def calculate_g(node, parent_node)
    node_row, node_column = node.first, node.last
    parent_row, parent_column = parent_node.first, parent_node.last
    
    vertical_distance = (parent_row - node_row).abs 
    horizontal_distance = (parent_column - node_column).abs
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
        adjacent_node = [(current_row + row).abs, (current_column + col).abs]
        nodes << adjacent_node if !nodes.include?(adjacent_node) && in_bounds?(adjacent_node)
      end
    end
    
    nodes
  end
end

# DEBUG METHODS
def show_possible_moves(available_node_list)
  possible_moves_maze_array = maze_array.map(&:clone)
  available_node_list.keys.each { |node| possible_moves_maze_array[node.first][node.last] = "0" }
  puts possible_moves_maze_array
  possible_moves_scores = @path_scores.select { |node, scores| available_node_list.include?(node) }
  possible_moves_scores.each {|node, scores| puts "#{node} : #{scores}" }
end

def clean_marks
  @closed_list.each { |node| maze_array[node.first][node.last] = " "}
end

def show_closed
  closed_maze = maze_array.map(&:clone)
  @closed_list.each { |node| closed_maze[node.first][node.last] = "C" }
  puts closed_maze
end

if $PROGRAM_NAME == __FILE__
  filename = ARGV[0] || "maze1.txt"
  test_solver = MazeSolver.new(filename)
  test_solver.solve
end