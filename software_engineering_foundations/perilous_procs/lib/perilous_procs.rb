require "byebug"

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

def at_least?(arr, n, &block)
  count = 0
  arr.each { |ele| count += 1 if block.call(ele) }
  count >= n
end

def every?(arr, &block)
  arr.each { |ele| return false if !block.call(ele) }
  true
end

def at_most?(arr, n, &block)
  count = 0
  arr.each { |ele| count += 1 if block.call(ele) }
  count <= n
end

def first_index(arr, &block)
  (0...arr.length).each { |idx| return idx if block.call(arr[idx]) }
  nil
end

# phase_2
def xnor_select(arr, prc_1, prc_2)
  selected = []
  selected
    .concat(arr.select { |ele| prc_1.call(ele) && prc_2.call(ele) })
    .concat(arr.select { |ele| !prc_1.call(ele) && !prc_2.call(ele) })
end

def filter_out!(arr, &block)
  filtered = false
  while !filtered
    filtered = true

    arr.each.with_index do |ele, idx|
      if block.call(ele)
        arr.delete_at(idx)
        filtered = false
      end
    end
  end

  arr
end

def multi_map(arr, n = 1, &block)
  mapped = arr.clone
  n.times { mapped.map! { |ele|block.call(ele) } }
  mapped
end