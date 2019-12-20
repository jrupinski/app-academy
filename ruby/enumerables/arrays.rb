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
end