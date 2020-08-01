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
    mins = []
    mins << @inqueue.min unless @inqueue.empty?
    mins << @outqueue.min unless @outqueue.empty?
    mins.min
  end

  def max
    maxes = []
    maxes << @inqueue.max unless @inqueue.empty?
    maxes << @outqueue.max unless @outqueue.empty?
    maxes.max
  end

  private

  def move_to_outqueue
    @outqueue.push(@inqueue.pop) until @inqueue.empty?
  end
end