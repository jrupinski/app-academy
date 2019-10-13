# Create a bootcamp
# parameters: name: str, slogan: str, student_capacity: int
# variables: teachers: arr of str, grades: hash of arrays, of int
class Bootcamp
  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @students = []
    @student_capacity = student_capacity
    @teachers = [] # arr of strings  
    @grades = Hash.new { |hash, key| hash[key] = [] }
  end

  def name
    @name
  end

  def slogan
    @slogan
  end

  def students
    @students
  end

  def student_capacity
    @student_capacity
  end

  def teachers
    @teachers
  end

  def grades
    @grades
  end
  
  # instance methods
  def hire(teacher)
    teachers << teacher
  end

  def enroll(student)
    if @students.length < @student_capacity
      @students << student
      true
    else
      false
    end
  end

  def enrolled?(student)
    students.include?(student)
  end

end
