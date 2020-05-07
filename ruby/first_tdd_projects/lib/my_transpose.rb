def my_transpose(matrix)
  raise ArgumentError unless matrix.all? { |row| row.size == matrix.size}

  transposed = Array.new(matrix.size) { Array.new }


  matrix.each do |row|
    row.each_with_index { |ele, col| transposed[col] << ele }
  end

  transposed
end