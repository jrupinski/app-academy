class Testclass
  @@nationality = "Polish"
  RACE = "white"

  def initialize(name, color, age)
    @name = name
    @color = color
    @age = age
  end

  def self.is_older(person_1, person_2)
    if (person_1.age > person_2.age)
      return person_1.name
    else
      return person_2.name
    end
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def nationality
    @@nationality
  end

  def self.nationality=(nation)
    @@nationality = nation
  end

  def race
    RACE
  end

  def age
    @age
  end

  def self.afro
    puts "Wrrr"
  end
end

test = Testclass.new("Joe", "red", 29)
test2 = Testclass.new("Eniu", "blue", 33)

p test
p test.name
test.name = "Rupcio"
p test.name
p test.nationality
Testclass.nationality = "Danish"
puts
p test.nationality
p test2.nationality
p test.race
p test2.race

Testclass.afro


p Testclass.is_older(test, test2)
