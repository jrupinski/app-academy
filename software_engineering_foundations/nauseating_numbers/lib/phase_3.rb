require "byebug"
require_relative "./phase_2.rb"

def matrix_addition_reloaded(*matrices)
  # debugger
  return nil if !same_array_size?(matrices)

  mat_sum = matrices[0]
  matrices[1...matrices.length].each do |curr_matrix|
    mat_sum = matrix_addition(mat_sum, curr_matrix)
  end

  mat_sum
end
  # return matrix_addition(arrays[0], arrays[1]) if arrays.length == 2

  # matrix_addition(arrays[0], matrix_addition_reloaded(arrays[1...arrays.length]))
  # mat_sum = []

  # (0...arrays.length - 1).each do |arr_num|
  #   mat_1 = arrays[arr_num]
  #   mat_2 = arrays[arr_num + 1]

  #   (0...mat_1.length).each do |row|
  #     curr_row = []

  #     (0...mat_1[row].length).each do |col|
  #       curr_row = mat_1[row][col] + mat_2[row][col]
  #     end

  #     mat_sum << curr_row
  #   end
  # end

  # mat_sum
  # end

def same_array_size?(*arrays)
  arrays.all? do |array|
    (0...array.length - 1).all? do |sub_arr|
      array[sub_arr].length == array[sub_arr + 1].length
    end
  end
end

# def matrix_addition(mat_1, mat_2)
#   mat_sum = Array.new(mat_1.length) { Array.new(mat_1[0].length) }

#   (0...mat_1.length).each do |row|
#     (0...mat_1[row].length).each do |col|
#       mat_sum[row][col] = mat_1[row][col] + mat_2[row][col]
#     end
#   end

#   mat_sum
# end