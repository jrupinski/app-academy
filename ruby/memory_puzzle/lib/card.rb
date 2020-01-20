class Card
  def initialize(value)
    @value = value
    @face_up = false
  end

  def show_value
    value
  end
  
  private

  def value
    @face_up ? @value : nil
  end
  
  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    @value.to_s
  end

  def ==(other_card)
    self.to_s == other_card.to_s
  end
end