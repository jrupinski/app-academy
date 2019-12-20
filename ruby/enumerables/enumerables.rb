# Enumerables for Ruby->Enumerables exercise
class Array
  #
  # Extend the Array class to include a method named my_each that takes a block, calls the block on every element of the array, and returns the original array. Do not use Enumerable's each method.
  #
  # @param [Proc] &block Block to execute
  #
  # @return [Array] Original array
  #
  def my_each(&block)
    self.size.times do |index|
      ele = self[index]
      block.call(ele)
    end

    self
  end

  #
  # Takes a block and returns a new array containing only elements that satisfy the block. Use your my_each method!
  #
  # @param [Proc] &block Block of code to execute
  #
  # @return [Array] Elements of original array that satisfy the block 
  #
  def my_select(&block)
    selected = []
    self.my_each { |ele| selected << ele if block.call(ele) }
    selected
  end

  #
  # Take a block and return a new array excluding elements that satisfy the block.
  #
  # @param [Proc] &block Block of code to execute
  #
  # @return [Array] Array of elements excluding rejected ones
  #
  def my_reject(&block) 
    not_rejected = []
    self.my_each { |ele| not_rejected << ele if !block.call(ele) }
    not_rejected
  end
end