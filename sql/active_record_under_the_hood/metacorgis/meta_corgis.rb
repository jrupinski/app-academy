# Today we'll use metaprogramming to refactor an unwieldy CorgiSnacks class.
# The SnackBox class represents our database.

# The database has three boxes of corgi snacks, stored in the SNACK_BOX_DATA constant. Each box has three corgi snacks - a bone, kibble, and a treat.

# It also has methods defined to tell us the info and tastiness rating of a given snack in whichever box we specify - e.g. get_{snack}_info and get_{snack}_tastiness. 
# So if we wanted to know the tastiness level of the bone in box two, we would simply call get_bone_tastiness(2) on an instance of SnackBox.
class SnackBox
  SNACK_BOX_DATA = {
    1 => {
      "bone" => {
        "info" => "Phoenician rawhide",
        "tastiness" => 20
      },
      "kibble" => {
        "info" => "Delicately braised hamhocks",
        "tastiness" => 33
      },
      "treat" => {
        "info" => "Chewy dental sticks",
        "tastiness" => 40
      }
    },
    2 => {
      "bone" => {
        "info" => "An old dirty bone",
        "tastiness" => 2
      },
      "kibble" => {
        "info" => "Kale clusters",
        "tastiness" => 1
      },
      "treat" => {
        "info" => "Bacon",
        "tastiness" => 80
      }
    },
    3 => {
      "bone" => {
        "info" => "A steak bone",
        "tastiness" => 64
      },
      "kibble" => {
        "info" => "Sweet Potato nibbles",
        "tastiness" => 45
      },
      "treat" => {
        "info" => "Chicken bits",
        "tastiness" => 75
      }
    }
  }
  def initialize(data = SNACK_BOX_DATA)
    @data = data
  end

  def get_bone_info(box_id)
    @data[box_id]["bone"]["info"]
  end

  def get_bone_tastiness(box_id)
    @data[box_id]["bone"]["tastiness"]
  end

  def get_kibble_info(box_id)
    @data[box_id]["kibble"]["info"]
  end

  def get_kibble_tastiness(box_id)
    @data[box_id]["kibble"]["tastiness"]
  end

  def get_treat_info(box_id)
    @data[box_id]["treat"]["info"]
  end

  def get_treat_tastiness(box_id)
    @data[box_id]["treat"]["tastiness"]
  end
end

# The CorgiSnacks class serves as an interface with our database.
# CorgiSnacks must contain a reference to the database (an instance of SnackBox) and its box_id within the database. 
# We should be able to call bone, kibble, or treat on any instance of CorgiSnacks and get back a statement of the info and tastiness level of that snack.
class CorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  def bone
    info = @snack_box.get_bone_info(@box_id)
    tastiness = @snack_box.get_bone_tastiness(@box_id)
    result = "Bone: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def kibble
    info = @snack_box.get_kibble_info(@box_id)
    tastiness = @snack_box.get_kibble_tastiness(@box_id)
    result = "Kibble: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

  def treat
    info = @snack_box.get_treat_info(@box_id)
    tastiness = @snack_box.get_treat_tastiness(@box_id)
    result = "Treat: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end

end

# This class will refactor the CorgiSnacks class into a one modular class to DRY things up
class MetaCorgiSnacks
  def initialize(snack_box, box_id)
    @snack_box = snack_box
    @box_id = box_id
  end

  # DRY up the methods #get_x_info and #get_x_tastiness to a universal module that returns that info if given snack is available
  def method_missing(name, *args)
    raise ArgumentError, "Too many arguments" if args.count != 0

    info = @snack_box.send("get_#{name}_info", @box_id)
    tastiness = @snack_box.send("get_#{name}_tastiness", @box_id)
    result = "Treat: #{info}: #{tastiness} "
    tastiness > 30 ? "* #{result}" : result
  end


  def self.define_snack(name)
    # Your code goes here...
  end
end
