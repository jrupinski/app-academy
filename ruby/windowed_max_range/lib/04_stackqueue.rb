require_relative "03_mystack"

class StackQueue
  def initialize
    @unqueued_stack = MyStack.new
    @queued_stack = MyStack.new
  end

  def enqueue(item)
    if @queued_stack.empty?
      @queued_stack.push(item)
    else
      # move all current items to unqueed stack, insert new item into queued stack, then put them back
      # ...now it's still a stack, but acts like a queue!
      @queued_stack.size.times { @unqueued_stack.push(@queued_stack.pop) }
      @queued_stack.push(item)
      @unqueued_stack.size.times { @queued_stack.push(@unqueued_stack.pop) }
    end
  end

  def dequeue
    @queued_stack.pop
  end

  def peek
    @queued_stack.peek
  end

  def empty?
    @queued_stack.empty?
  end

  def size
    @queued_stack.size
  end
end