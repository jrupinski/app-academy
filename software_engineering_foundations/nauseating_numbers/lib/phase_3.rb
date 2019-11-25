require "byebug"
require_relative "./phase_2.rb"

def matrix_addition_reloaded(*matrices)
  return nil if !same_array_size?(*matrices)

  mat_sum = matrices[0]
  matrices[1...matrices.length].each do |curr_matrix|
    mat_sum = matrix_addition(mat_sum, curr_matrix)
  end

  mat_sum
end

def same_array_size?(*matrices)
  (0...matrices.length - 1).each do |mat_idx|
    curr_matrix = matrices[mat_idx]
    next_matrix = matrices[mat_idx + 1]

    # compare num of rows in every matrix
    return false if curr_matrix.length != next_matrix.length

    # compare num of elements of every row in every matrix 
    (0...curr_matrix.length).each do |row|
        return false if curr_matrix[row].length != next_matrix[row].length
    end
  end

  true
end

def squarocol?(multi_array)
  return false if !same_array_size?(multi_array)

  (0...multi_array.length).any? do |row_idx|
    row = multi_array[row_idx]
    col = []
    (0...multi_array.length).each do |col_idx|
      col << multi_array[col_idx][row_idx]
    end
    
    # row or column is filled with same element 
    row.uniq.one? || col.uniq.one?
  end
end
