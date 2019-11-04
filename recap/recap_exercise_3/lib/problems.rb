require "byebug"

def no_dupes?(arr)
  arr.reject do |ele|
    # debugger
    arr.count(ele) > 1
  end
end