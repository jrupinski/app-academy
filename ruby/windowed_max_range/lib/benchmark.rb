require "benchmark"
require 'io/console'
require_relative "07_maxwindowedrange"
# require_relative "01_naive"

def max_windowed_range_unoptimized(array, window_size)
best_range = nil

# universal version
# (0..array.length - window_size).each do |i|
#   window = array[i...i + window_size]
#   current_max_range = window.max - window.min
#   if best_range.nil? || current_max_range > best_range
#     best_range = current_max_range
#   end
# end

array.each_cons(window_size) do |window|
  current_max_range = window.max - window.min
  if best_range.nil? || current_max_range > best_range  
    best_range = current_max_range
  end
end

best_range
end



def self.performance_test(size, count, window_size)
  arrays_to_test = Array.new(count) { random_arr(size) }

  Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                  "Avg. (n*m) time", "Avg. O(n) time: ") do |b|
    n_squared = b.report("Tot. O(n*m):  ") do
      arrays_to_test.each { |arr| max_windowed_range_unoptimized(arr, window_size) }
    end
      
    n_linear = b.report("Tot. O(n): ") do
      arrays_to_test.each { |arr| max_windowed_range(arr, window_size) }
    end

    [n_squared/count, n_linear/count]
  end
end

def self.run_performance_tests(multiplier = 5, rounds = 3, window_size = 3)
  [1, 10, 100, 1000, 10000, 100000].each do |size|
    size *= multiplier
    wait_for_keypress(
      "Press any key to benchmark sorts for #{size} elements"
    )
    performance_test(size, rounds, window_size)
  end
end

def self.wait_for_keypress(prompt)
  puts
  puts prompt
  STDIN.getch
end

def self.random_arr(n)
  Array.new(n) { rand(n) }
end

if __FILE__ == $PROGRAM_NAME
  self.run_performance_tests
end