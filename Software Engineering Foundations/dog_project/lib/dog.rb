require "byebug"

# Creates a Dog instance
# Dog instance requires a name(str), breed(str), age(int), bark(str), favorite_foods(arr of str)
class Dog
  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark
    @favorite_foods = favorite_foods
  end

  # getters
  def name
    @name
  end

  def breed
    @breed
  end

  def age
    @age
  end

  def bark
  @bark
  end

  def favorite_foods
    @favorite_foods
  end

  # setters
  def age=(age)
    @age = age
  end

  # instance methods
  def bark
    # debugger
    (@bark.upcase if self.age > 3) || @bark.downcase
  end

  def favorite_food?(food_str)
    # debugger
    @favorite_foods.map(&:downcase).include?(food_str.downcase)
  end
end
