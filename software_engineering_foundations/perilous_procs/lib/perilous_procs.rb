# phase_1
def some?(arr, &block)
  arr.each { |ele| return true if block.call(ele) }
  false
end

def exactly?(arr, n, &block)
  count = 0
  arr.each { |ele| count += 1 if block.call(ele) }
  count == n
end

def filter_out(arr, &block)
  filtered = []
  arr.each { |ele| filtered << ele if block.call(ele) == false}
  filtered
end