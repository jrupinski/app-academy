require "byebug"
class LRUCache
def initialize(capacity = 4)
  @capacity = capacity
  @cache = []
end

# returns number of elements currently in cache
def count
  @cache.count
end

# adds element to cache according to LRU principle
# TODO: fix sorting, items are added at the same time and are not sorted right
def add(el)
  el_idx = @cache.index {|value, timestamp| value == el }

  unless el_idx.nil?
    item = @cache[el_idx]
    @cache[el_idx] = update_timestamp(item)
  else
    value = [el, current_timestamp]
    self.count < @capacity ? @cache << value : @cache[0] = value
  end
  
  @cache.sort_by! { |val, timestamp| timestamp }
end

# shows the items in the cache, with the LRU item first
def show
  @cache.map { |ele, timestamp| ele }
end

private
# helper methods go here!

  def current_timestamp
    Time.now.getutc.to_s
  end

  def update_timestamp(item)
    raise ArgumentError unless item.is_a?(Array)
    item[1] = current_timestamp

    item
  end

end