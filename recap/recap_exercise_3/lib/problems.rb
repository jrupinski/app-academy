require "byebug"

def no_dupes?(arr)
  arr.reject do |ele|
    # debugger
    arr.count(ele) > 1
  end
end

def no_consecutive_repeats?(arr)
  (0...arr.length - 1).each do |i|
    return false if arr[i] == arr[i + 1]
  end
  true
end
