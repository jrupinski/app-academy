def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(array)
    array.sum(0.0) / array.length
end

def repeat(str, num)
    new_str = ""
    num.times { new_str += str }
    new_str
end

def yell(str)
    str.upcase + "!" 
end

def alternating_case(str)
    new_str = []

    str.split.each_with_index do |word, i|
        if i.even?
            new_str << word.upcase
        else
            new_str << word.downcase
        end
    end

    new_str.join(" ")
end