require "byebug"
#
# Check stocks prices for every day and return the best day to buy and sell (max profit).
# First value is Buy price, second is Sell price
#
# @param [Array] stocks_array Array of days, each subarray is a pair of Buy and Sell values 
#
# @return [Array] Pair of days which return max profit (lowest buy, highest sell)
#
def stock_picker(stocks_array)
  raise ArgumentError unless stocks_array.all? { |day| day.is_a?(Array) && day.size == 2 && day.all? { |stock| stock.is_a?(Numeric) } && stocks_array.count > 1}
  # debugger
  most_profitable_pair = [0, 0]
  best_profit = stocks_array[0].last - stocks_array[0].first
  for buy_day in 0...stocks_array.size
    for sell_day in buy_day...stocks_array.size
      buy = stocks_array[buy_day].first
      sell = stocks_array[sell_day].last
      
      profit = sell - buy
      profit > best_profit ? best_profit = profit : next
      most_profitable_pair = [buy_day, sell_day]
    end

  end
  
  raise RangeError if most_profitable_pair.first > most_profitable_pair.last
  most_profitable_pair
end