=begin
  Class of Dog
  Initialization variables:
  @name: string
  @breed: string
  @age: string
  @bark: string
  @favorite_foods: array of string  
=end

class Dog
  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark
    @favorite_foods = favorite_foods
  end

  def name
    @name
  end

  def breed
    @breed
  end

  def age
    @age
  end
  
  def age=(age)
    @age = age
  end

  # bark in all caps if dog is older than 3, else bark lowercase
  def bark
    if @age > 3
      @bark.upcase
    else
      @bark.downcase
    end
  end

  def favorite_foods
    @favorite_foods
  end

  # check if given string is included in favorite foods
  def favorite_food?(string)
    @favorite_foods.map(&:downcase).include?(string.downcase)
  end
end