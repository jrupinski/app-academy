require "employee"
require "manager"

describe "Class inheritance" do
  describe "Class extension" do
    it "Creates Managers (extension of Employee)" do
      expect { Manager.new("Ned", "Founder", 1000000,  nil) }.to_not raise_error
      ned = Manager.new("Ned", "Founder", 1000000,  nil)
      expect { Manager.new("Darren", "TA Manager", 78000, ned) }.to_not raise_error
    end

    it "Creates Employees" do
      expect { Employee.new("David", "TA", 10000, darren) }.to_not raise_error
    end

    let (:ned) { Manager.new("Ned", "Founder", 1000000,  nil) }
    let (:darren) { Manager.new("Darren", "TA Manager", 78000, ned) }
    
    before { ned.employees << darren }
    let (:shawna) { Employee.new("Shawna", "TA", 12000, darren) }
    let (:david) { Employee.new("David", "TA", 10000, darren) }
    before { darren.employees += [shawna, david] }

    describe "Method overriding" do
      
      it "Calculates Employee's bonus by multiplying it by a number/percentage" do
        expect(david.bonus(3)).to eq(30000)
      end
      
      it "Calculates Manager's bonus based on the total salary of all of their subordinates, as well as the manager's subordinates' subordinates, and the subordinates' subordinates' subordinates, etc." do
        expect(ned.bonus(5)).to eq(500000)
        expect(darren.bonus(4)).to eq(88000)
      end
    end
  end
end