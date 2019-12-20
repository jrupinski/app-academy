# Methods for Ruby->Enumerables exercise
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
end