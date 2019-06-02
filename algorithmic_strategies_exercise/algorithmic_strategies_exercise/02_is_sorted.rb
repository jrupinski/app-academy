# Write a method, is_sorted(arr), that accepts an array of numbers as an arg.
# The method should return true if the elements are in increasing order, false otherwise.
# Do not use the built-in Array#sort in your solution :)

# def is_sorted(arr)
#     arr.each_with_index do |ele1, idx1|
#         arr.each_with_index do |ele2, idx2|
#             if idx2 > idx1 && ele1 > ele2  # if curr ele is bigger than next - not in order, return false
#                 return false
#             end
#         end
#     end
#     return true
# end

def is_sorted(arr)
    last_idx = arr.length - 1

    (0...last_idx).each_with_index do |ele, i|
        if arr[i] > arr[i + 1]
            return false
        end
    end

    return true
end

p is_sorted([1, 4, 10, 13, 15])       # => true
p is_sorted([1, 4, 10, 10, 13, 15])   # => true
p is_sorted([1, 2, 5, 3, 4 ])         # => false
