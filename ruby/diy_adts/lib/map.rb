class Map
  def initialize
    @map = []
  end

  def get(key)
    pair = @map.select { |ele| ele.first == key }.flatten
    pair.last
  end

  def set(key, value)
    key_idx = @map.find_index { |(ele_key, ele_val)| ele_key == key }
    key_idx.nil? ? @map.push([key, value]) : @map[key_idx].replace([key, value])
  end

  def delete(key)
    key_idx = @map.find_index { |(ele_key, ele_val)| ele_key == key }
    @map.delete_at(key_idx) unless key_idx.nil?
  end

  def show
    @map
  end
end