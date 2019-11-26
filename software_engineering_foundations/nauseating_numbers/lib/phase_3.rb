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

  rows = multi_array
  columns = get_matrix_columns(multi_array)
  # row or column is filled with same element 
  rows.any? { |row| row.uniq.one? } || columns.any? { |col| col.uniq.one? }
end

def squaragonal?(multi_array)
  return false if !same_array_size?(multi_array)

  diagonals = get_matrix_diagonals(multi_array)
  # check if any diagonal filled with same element
  diagonals.any? { |diagonal| diagonal.uniq.one? }
end

def get_matrix_columns(matrix)
  columns = []

  (0...matrix.length).each do |row_idx|
    curr_col = []
    (0...matrix.length).each do |col_idx|
      curr_col << matrix[col_idx][row_idx]
    end
    columns << curr_col
  end

  columns
end

def get_matrix_diagonals(matrix)
  diagonals = []

  # get both diagonals - left and right
  2.times do
    diagonals << (0...matrix.length).inject([]) do |diagonal, diag_idx|

      if diagonals.empty? # get left diagonal first
        diagonal << matrix[diag_idx][diag_idx]
      else                # get right diagonal
        diagonal << matrix[diag_idx][-1 - diag_idx]
      end

    end
  end

  diagonals
end
