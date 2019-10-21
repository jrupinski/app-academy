require "employee"
require "byebug"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @salaries = salaries
    @funding = funding
    @employees = []
  end


  def valid_title?(title)
    @salaries.has_key?(title)
  end
  
  def >(another_startup)
    @funding > another_startup.funding
  end

  def hire(name, title)
    if self.valid_title?(title)
      new_employee = Employee.new(name, title)
      @employees << new_employee
    else
      raise "title invalid!"
    end
  end
  
  def size
    @employees.length
  end

  def pay_employee(employee)
    salary = @salaries[employee.title]

    if @funding >= salary
      @funding -= salary
      employee.pay(salary)
    else
      raise "Not enough funding for salary"
    end
  end

  def payday
    employees.each { |employee| pay_employee(employee) }
  end

  def average_salary
    emp_count = @employees.length
    emp_sum = @employees.sum do |emp|
      @salaries[emp.title]
    end
    
    emp_sum / emp_count
  end

  def close
    @funding = 0
    @employees.clear
  end

  def acquire(another_startup)
    @funding += another_startup.funding
    self.employees.concat(another_startup.employees)
    # debugger
    self.salaries.merge!(another_startup.salaries) { |title, old_salary, new_salary| old_salary || new_salary }
    another_startup.close
  end
end
