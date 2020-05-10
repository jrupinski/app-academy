require "stock_picker"

describe "Stock Picker" do

  subject(:stocks) do
      # BUY PRICE, SELL PRICE
    [
      [8.11367330413983, 12.88859956742981],
      [20.34013642966382, 33.101916328331114],
      [39.85154142286985, 21.536100706233327],
      [92.53160038660971, 56.17223541513063],
      [26.987686618976362, 47.36130729894862],
      [95.75420419285764, 24.707912335923485],
      [33.28138751183998, 8.28449130910686],
      [47.68555218371556, 35.35329728438478],
      [43.88973829564867, 15.236077019256845],
      [8.24013168442964, 60.165504792189076]
    ]
  end

  it "Accepts an Array of stock prices (prices on days 0, 1, ...)" do
    expect { stock_picker(stocks) }.to_not raise_error
    expect { stock_picker([1, 2, 3]) }.to raise_error(ArgumentError)
  end

  it "Outputs the most profitable pair of days on which to first buy the stock and then sell the stock" do
    expect(stock_picker(stocks)).to eq([0, 9])
    expect(stock_picker(stocks.take(4))).to eq([0, 3])
  end

  # this test doesn't work as intended, sadly
  # it "Cannot sell stock before you buy it" do
  #   allow(self).to receive(:stock_picker).with(stocks).and_return([6, 1])
  #   expect { stock_picker(stocks) }.to raise_error(RangeError)
  #   allow(self).to receive(:stock_picker).with(stocks).and_return([1, 6])
  #   expect { stock_picker(stocks) }.to_not raise_error(RangeError)
  # end
end