require_relative "05_minmaxstack"

class MinMaxStackQueue
  def initialize
    @inqueue = MinMaxStack.new
    @outqueue = MinMaxStack.new
  end

  def enqueue(item)
    @inqueue.push(item)
  end

  def dequeue
    return @outqueue.pop unless @outqueue.empty?
    move_to_outqueue
    @outqueue.pop
  end

  def peek
    move_to_outqueue if @outqueue.empty?
    @outqueue.peek
  end

  def empty?
    @inqueue.empty? && @outqueue.empty?
  end

  def size
    @inqueue.size + @outqueue.size
  end

  def min
    @inqueue.min || @outqueue.min unless empty?
  end

  def max
    @inqueue.max || @outqueue.max unless empty?
  end

  private

  def move_to_outqueue
    @inqueue.size.times { @outqueue.push(@inqueue.pop) }
  end
end