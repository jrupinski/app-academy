require "byebug"
# Array methods for Ruby->Enumerables exercise
class Array
  #
  # Return all elements of the array into a new, one-dimensional array. Hint: use recursion!
  #
  # @return [Array] 1-dimensional array with all elements of original array
  #
  def my_flatten
    return [self] if !self.is_a?(Array)
    
    flattened = []
    self.each do |ele|
      ele.is_a?(Array) ? flattened += ele.my_flatten : flattened << ele 
    end
    
    flattened
  end

  #
  # Take any number of arguments. It should return a new array containing self.length elements. Each element of the new array should be an array with a length of the input arguments + 1 and contain the merged elements at that index. If the size of any argument is less than self, nil is returned for that location.
  #
  # @param [<Type>] *args <description>
  #
  # @return [<Type>] <description>
  #
  def my_zip(*args)
    zipped = Array.new(self.length) { Array.new }

    (0...self.length).each do |index|
      zipped[index] << self[index]
      args.each { |arg_array| zipped[index] << arg_array[index] }
    end
      
    zipped
  end


  #
  # Write a method my_rotate that returns a new array containing all the elements of the original array in a rotated order. By default, the array should rotate by one element. If a negative value is given, the array is rotated in the opposite direction.
  #
  # @param [Integer] num_of_rotations How many times to rotate 
  #
  # @return [Array] Rotated Array
  #
  def my_rotate(num_of_rotations = 1)
    rotated = self.clone

    if num_of_rotations > 0
      num_of_rotations.times { rotated << rotated.shift }
    else
      num_of_rotations.abs.times { rotated.unshift(rotated.pop) }
    end
    
    rotated
  end

  #
  # my_join returns a single string containing all the elements of the array, separated by the given string separator. If no separator is given, an empty string is used.
  #
  # @param [String] separator String separator
  #
  # @return [String] String with all arguments joined by separator
  #
  def my_join(separator = "")
    joined = ""
    self.each { |ele| joined += (ele.to_s + separator) }
    joined.chomp(separator)
  end
end