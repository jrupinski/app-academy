require_relative "03_mystack"

class MinMaxStack
  def initialize
    @store = MyStack.new
  end

  def peek
    @store.peek[:value]
  end

  def push(item)
    @store.push ({ 
      :value => item,
      :max => new_max(item),
      :min => new_min(item) 
    })
  end

  def pop
    @store.pop[:value]
  end

  def empty?
    @store.empty?
  end

  def size
    @store.size
  end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  private

  def new_max(value)
    empty? ? value : [max, value].max
  end

  def new_min(value)
    empty? ? value : [min, value].min
  end
end