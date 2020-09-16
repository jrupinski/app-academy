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
    elsif i >= capacity
      resize! until capacity >= i
    end
    @count += 1 if @store[i] == nil && !val.nil?
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
    last_item = self.last.dup
    self[last_idx] = nil
    @count -= 1
    
    resize! if count < (capacity * 0.25)
    last_item
  end
  
  def shift
    return nil unless count > 0 
    first_ele = self.first.dup
    self[0] = nil
    @count -= 1
    # move every item one index to the left
    (1...capacity).each do |idx|
      self[idx], self[idx - 1] = self[idx - 1], self[idx]
      @count -= 1 unless self[idx].nil? && self[idx - 1].nil?
    end

    first_ele
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
    # Calculate new size
    new_size = (@count >= capacity ? capacity * 2 : capacity / 2)
    # don't downsize past minimum size
    return false if new_size < 1

    # Copy elements from current Array
    elements = self.map.with_index { |ele, idx| [ele, idx] }.dup

    # Resize @store Array
    @store = StaticArray.new(new_size)
    @count = 0

    # Reinsert elements in their respective index in resized Array 
    elements.each { |ele, idx| self[idx] = ele unless ele.nil?}
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
