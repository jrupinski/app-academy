require "byebug"
# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple 
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    multiple = 1
    multiple += 1 until multiple % num_1 == 0 && multiple % num_2 == 0
    multiple
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigram_count = Hash.new(0)

    # count each bigram appearance
    (0...str.length - 1).each do |i|
        bigram = str[i] + str[i+1]
        bigram_count[bigram] += 1
    end

    # return most frequent bigram
    bigram_count.max_by { |k, v| v }.first
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        inversed = {}
        self.each { |key, val| inversed[val] = key }
        inversed
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        
        # check every possible pair sum in array
        (0...self.length - 1).each do |idx1|
            (idx1 + 1...self.length).each do |idx2|
                pair_sum = self[idx1] + self[idx2]
                count += 1 if pair_sum == num
            end
        end

        count
    end


    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    def bubble_sort(&prc)
        prc = Proc.new{ |ele1, ele2| ele1 > ele2 }
        
        sorted = false
        while !sorted
            sorted = true
            
            (0...self.length - 1).each do |i|
                ele1 = self[i]
                ele2 = self[i+1]
                
                # debugger
                if prc.call(ele1, ele2)
                        self[i], self[i+1] = self[i+1], self[i]
                        sorted = false
                    end
            end
        end

        self
    end
end

[4, 12, 2, 8, 1, 14, 9, 25, 24, 81].bubble_sort { |a, b| a.to_s <=> b.to_s }