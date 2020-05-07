require "my_transpose"

describe "my_transpose" do
  subject(:valid_matrix) do 
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
  end

  subject(:invalid_matrix)  do
    [
      [0],
      [3, 5],
      [6, 7, 8]
    ]
  end

  subject(:transposed_matrix)  do
    [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]
  end

  it "Accepts a square matrix as an argument" do
    expect { my_transpose(invalid_matrix) }.to raise_error(ArgumentError)
    expect { my_transpose(valid_matrix) }.to_not raise_error
  end

  it "Converts between row-oriented and column-oriented representations of a matrix" do
    expect(my_transpose(valid_matrix)).to eq(transposed_matrix)
    expect(my_transpose(transposed_matrix)).to eq(valid_matrix)
  end

  it "Doesn't modify the original matrix" do
    expect { my_transpose(valid_matrix) }.to_not change { valid_matrix.object_id }
    expect { my_transpose(transposed_matrix) }.to_not change { transposed_matrix.object_id }
  end

end