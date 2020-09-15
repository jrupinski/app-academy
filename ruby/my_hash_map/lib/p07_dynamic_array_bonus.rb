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
    # TODO: fix over-indexing
    # count in reverse when number is negative: -1 is last ele, -2 is second last etc.
    if i < 0 && i >= (-count)
      i %= count 
    # else
    #   self.push(nil) until capacity >= i
    end
    @count += 1 if @store[i] == nil
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
    # return inserted val
    val
  end

  def unshift(val)
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
    self[last_idx] = nil
    @count -= 1
    
    resize! if count < (capacity * 0.25)
    last_item
  end

  def shift
    return nil unless count > 0 
    first_ele_copy = self.first.dup
    self[first_idx] = nil
    @count -= 1
    return first_ele_copy if count <= 0
    
    # move every item one index to the left
    (first_idx...capacity).each do |idx|
      ele = self[idx]
      prev_idx = idx - 1

      self[prev_idx] = ele
      self[idx] = nil
      # remove one to keep counter the same - we're just moving, not adding elements
      @count -= (ele.nil? ? 2 : 1)
    end

    first_ele_copy
  end

  #
  # return first non-nil element from array
  #
  def first
    self.each { |ele| return ele unless ele.nil? }
    nil
  end

  def last
    self.reverse_each { |ele| return ele unless ele.nil? }
    nil
  end

  def each
    (0...capacity).each do |idx|
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
    elements = self.map.with_index { |ele, idx| [ele, idx] }
    elements.reject! {|ele, idx| ele.nil? }

    # create new Array, reset counter
    @store = StaticArray.new(new_size)
    @count = 0

    # rehash and reinsert elements in resized HashMap 
    elements.each { |ele, idx| self[idx] = ele}
  end

  #
  # Find index of first non-nil element in Array
  #
  # @return [Numeric] Integer with non-nil ele index
  #
  def first_idx
    self.each_with_index { |ele, idx| return idx unless ele.nil? }
    nil
  end

  def last_idx
    capacity.downto(0) { |idx| return idx unless self[idx].nil? }
    nil
  end
end
