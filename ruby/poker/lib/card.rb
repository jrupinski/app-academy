class Card

  VALUE_HASH = {
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13
  }

  def initialize(value)
    @value = value
  end

  def value
    raise ArgumentError unless @value.length.between?(2, 3)
    value_str = @value.chars.take(@value.length - 1).join
    VALUE_HASH.has_key?(value_str) ? VALUE_HASH[value_str] : (raise ArgumentError)
  end

end