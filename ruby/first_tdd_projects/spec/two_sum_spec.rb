require "two_sum"

describe "two_sum" do
  subject(:array) { [-1, 0, 2, -2, 1] }
  subject(:array_2) { [-1, 1, 1, -1, 3, -3] }

  it "finds all pairs of positions where the elements at those positions sum to zero" do
    expect(array.two_sum).to eq([[0, 4], [2, 3]])
  end

  it "Pairs are sorted smaller index before bigger index" do
    expect(array_2.two_sum).to eq([[0, 1], [0, 2], [1, 3], [2, 3], [4, 5]])
  end
end