# phase_1
def some?(arr, &block)
  arr.each { |ele| return true if block.call(ele) }
  false
end