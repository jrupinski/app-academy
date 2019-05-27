def reverser(string, &proc)
    proc.call(string.reverse)
end

def word_changer(string, &proc)
    words = string.split(" ")
    words.map! { |word| proc.call(word) }
    words.join(" ")
end

def greater_proc_value(num, proc1, proc2)
    proc1_val = proc1.call(num)
    proc2_val = proc2.call(num)
    
    if proc1_val > proc2_val
        return proc1_val
    else
        return proc2_val
    end    
end

def and_selector(array, proc1, proc2)
    array.select { |ele| proc1.call(ele) && proc2.call(ele) }
end

def alternating_mapper(arr, proc1, proc2)
    arr.map.with_index do |ele, i|
        if i.even?
            proc1.call(ele)
        else
            proc2.call(ele)
        end
    end
end