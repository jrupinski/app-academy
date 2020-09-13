require "byebug"

class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    @store.any { |ele| ele == val }
  end

  def push(val)
    resize! if capacity > count
    
    (0...capacity).each do |idx|

      if @store[idx].nil?
        @store[idx] = val
        @count += 1
        return val
      end
    end
  end

  def unshift(val)
    # TODO
  end

  def pop
    resize! if count < (@capacity * 0.25)

    (0...capacity).reverse_each do |idx|
      ele = @store[idx]
      
      unless ele.nil?
        @store[idx] = nil
        @count -= 1
        return ele
      end
    end

    nil
  end

  def shift
    # TODO
  end

  def first
    @store[0] unless @store[0].nil?
  end

  def last
    (0...capacity).reverse_each do |idx|
      return @store[idx] unless @store[idx].nil?
    end
  end

  def each
    (0...count).each do |idx|
      yield @store[idx]
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    # TODO Fix resizing


  # Create new Array
  capacity = @store.length
  new_size = (@count >= capacity ? capacity * 2 : capacity / 2)
  # don't downsize past default size
  return false if new_size < 8

  # store elements from current Array
  elements = @store.dup

  # create new Array, reset counter
  @store = StaticArray.new(new_size)
  @count = 0

  # rehash and reinsert elements in resized HashMap 
  elements.each { |ele| self.push(ele) }
  end
end
