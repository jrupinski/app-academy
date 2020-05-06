class Array
  def two_sum
    pairs = []

    self.each_with_index do |ele_1, idx_1|
      self.each_with_index do |ele_2, idx_2|
        pairs << [idx_1, idx_2] if ele_1 + ele_2 == 0 && idx_1 < idx_2
      end
    end

    pairs
  end
end