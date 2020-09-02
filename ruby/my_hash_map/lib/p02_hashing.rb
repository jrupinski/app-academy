class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    self
      # use XOR of each element and it's index as base for hashing
      .flatten
      .map.with_index { |ele, idx| ele.to_i ^ idx }
      .sum
      .hash
  end
end

class String
  def hash
    bytes = []
    # convert each char to bytes, and then hash that array of bytes
    self.each_byte { |char| bytes << char }
    # hash the byte array
    bytes.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # add keys and values to a single array
    hash_as_array = self.keys + self.values
    # convert any symbols in Array into a string
    hash_as_array.map! { |ele| ele.to_s }
    # sort keys and values to make the hash order-agnostic
    hash_as_array.sort!
    # hash the array of keys and values
    hash_as_array.hash
  end
end
