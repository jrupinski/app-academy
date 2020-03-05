class Queue
  def initialize
    @queue = []
  end

  def inspect()
    @queue
  end

  def enqueue(ele)
    @queue.push(ele)
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue.first
  end
end