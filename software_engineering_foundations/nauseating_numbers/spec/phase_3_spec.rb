require "phase_3"

describe "phase_3" do
  describe "matrix_addition_reloaded" do
    let (:matrix_a) { [[2,5], [4,7]] }
    let (:matrix_b) { [[9,1], [3,0]] }
    let (:matrix_c) { [[-1,0], [0,-1]] }
    let (:matrix_d) { [[2, -5], [7, 10], [0, 1]] }
    let (:matrix_e) { [[0 , 0], [12, 4], [6,  3]] }
    
    it "accepts any number of matrices as an arg" do
      expect { matrix_addition_reloaded(matrix_a, matrix_b, matrix_c) }.to_not raise_error
      expect { matrix_addition_reloaded(matrix_a) }.to_not raise_error
    end

    it "returns new matrix with all matrices' elements summed" do
      expect(matrix_addition_reloaded(matrix_a, matrix_b)).to eq([[11, 6], [7, 7]])
      expect(matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)).to eq([[10, 6], [7, 6]])
      expect(matrix_addition_reloaded(matrix_e)).to eq([[0, 0], [12, 4], [6, 3]])
      expect(matrix_addition_reloaded(matrix_d, matrix_e)).to eq([[2, -5], [19, 14], [6, 4]])

    end

    it "returns nil if matrices' dimensons are different" do 
      expect(matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)).to eq(nil)
      expect(matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)).to eq(nil)
    end
  end

  describe "squarocol?" do
    it "accepts square 2D array as an arg (arr height == arr width)" do
      expect { squarocol?([
        [1, 1, 1],
        [2, 2, 2],
        [3, 3, 3],
      ]) }.to_not raise_error
    end

    it "returns Boolean indicating if any row or column is filled with same elements" do
      expect(squarocol?([
        [:a, :x , :d],
        [:b, :x , :e],
        [:c, :x , :f],
      ])).to eq(true)
      

      expect(squarocol?([
        [:x, :y, :x],
        [:x, :z, :x],
        [:o, :o, :o],
      ])).to eq(true)

      expect(squarocol?([
        [:o, :x , :o],
        [:x, :o , :x],
        [:o, :x , :o],
      ])).to eq(false)

      expect(squarocol?([
        [1, 2, 2, 7],
        [1, 6, 6, 7],
        [0, 5, 2, 7],
        [4, 2, 9, 7],
      ])).to eq(true)

      expect(squarocol?([
        [1, 2, 2, 7],
        [1, 6, 6, 0],
        [0, 5, 2, 7],
        [4, 2, 9, 7],
      ])).to eq(false)
    end
  end

  describe "squaragonal?" do
    it "accepts square 2D array as an arg (arr height == arr width)" do
      expect(squaragonal?([
        [:x, :y, :o],
        [:x, :x, :x],
        [:o, :o, :x],
      ])).to eq(true)
    end

    it "returns Boolean indicating if either diagonal is filled with same elements" do
      expect(squaragonal?([
        [:x, :y, :o],
        [:x, :x, :x],
        [:o, :o, :x],
      ])).to eq(true)

      expect(squaragonal?([
        [:x, :y, :o],
        [:x, :o, :x],
        [:o, :o, :x],
      ])).to eq(true)

      expect(squaragonal?([
        [1, 2, 2, 7],
        [1, 1, 6, 7],
        [0, 5, 1, 7],
        [4, 2, 9, 1],
      ])).to eq(true)

      expect(squaragonal?([
        [1, 2, 2, 5],
        [1, 6, 5, 0],
        [0, 2, 2, 7],
        [5, 2, 9, 7],
      ])).to eq(false)
    end
  end

  describe "pascals_triangle" do
    it "accepts a positive number as an arg" do
      expect { pascals_triangle(2) }.to_not raise_error
    end

    it "returns a 2D array containing the first n levels of pascal's triangle." do
      expect(pascals_triangle(5)).to eq([
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1]
      ])

      expect(pascals_triangle(7)).to eq([
        [1],
        [1, 1],
        [1, 2, 1],
        [1, 3, 3, 1],
        [1, 4, 6, 4, 1],
        [1, 5, 10, 10, 5, 1],
        [1, 6, 15, 20, 15, 6, 1]
      ])
    end
  end
end
