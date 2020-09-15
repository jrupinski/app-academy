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
    # count in reverse when number is negative: -1 is last ele, -2 is second last etc.
    i %= count if i < 0 && i >= (-count)

    begin
      @store[i]
    rescue 
      # I'd create a separate Error class for rescuing but exercise forbids editing StaticArray Class
      # return nil if overindexing
      nil
    end
  end

  def []=(i, val)
    i %= count if i < 0 && i >= (-count)
    # count in reverse when number is negative: -1 is last ele, -2 is second last etc.
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.any? { |ele| ele == val }
  end

  def push(val)
    resize! if count >= capacity
    self[count] = val
    @count += 1
    # return inserted val
    val
  end

  def unshift(val)
    @count += 1
    resize! if count >= capacity

    # move every item one index to the right
    # start moving in reverse order to not overwrite values
    (0...@count).reverse_each do |idx|
      ele = self[idx]
      unless ele.nil?
        self[idx + 1] = ele
      end
    end

    # push val to beginning of the Array
    self[0] = val
  end

  def pop
    return nil if count <= 0

    last_item = self.last
    last_idx = count - 1
    self[last_idx] = nil
    @count -= 1
    
    resize! if count < (capacity * 0.25)
    last_item
  end

  def shift
    return nil unless count > 0 
    first_ele = self.first
    self[0] = nil
    @count -= 1

    # move every item one index to the left
    (1..@count).each do |idx|
      ele = self[idx]
      prev_idx = idx - 1

      self[prev_idx] = ele
      self[idx] = nil
    end

    first_ele
  end

  def first
    self[0] unless self[0].nil?
  end

  def last
    self[@count - 1] if self.count > 0
  end

  def each
    (0...count).each do |idx|
      yield self[idx]
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false if self.length != other.length
    (0...self.count).all? { |idx| self[idx] == other[idx] }
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  # Create new Array
  new_size = (@count >= capacity ? capacity * 2 : capacity / 2)
  # don't downsize past default size
  return false if new_size < 1

  # store elements from current Array
  elements = self.dup

  # create new Array, reset counter
  @store = StaticArray.new(new_size)
  @count = 0

  # rehash and reinsert elements in resized HashMap 
  elements.each { |ele| self.push(ele) }
  end
end
