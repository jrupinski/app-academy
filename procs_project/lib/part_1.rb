def my_map(array, &proc)
    new_array = []
    array.each { |ele| new_array << proc.call(ele) }

    new_array
end

def my_select(array, &block)
    new_array = []
    array.each { |ele| new_array << ele if block.call(ele) }

    new_array
end

def my_count(array, &block)
    sum = 0
    array.each { |ele| sum += 1 if block.call(ele) }
    sum
end

def my_any?(array, &block)
    array.each { |ele| return true if block.call(ele) }
    false
end

def my_all?(array, &proc)
    array.each { |ele| return false if !proc.call(ele) }
    true
end

def my_none?(array, &proc)
    array.each { |ele| return false if proc.call(ele) }
    true
end