def average(num_1, num_2)
  (num_1 + num_2) / 2.0
end

def average_array(arr)
  arr.sum / (arr.length * 1.0)
end

def repeat(str, reps)
  str * reps
end

def yell(str)
  str.upcase + "!"
end

def alternating_case(str)
  alternate = str.split.map.with_index do |word, i|
    if i.even?
      word.upcase
    else
      word.downcase
    end
  end
  alternate.join(" ")
end