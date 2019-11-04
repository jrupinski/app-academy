VARIABLES:
  Random value:
    rand(0..5)  =>  return random integer between 0 and 5

    
  if you create new variables they will have different IDs(memory location).
  if you MUTATE(var.upcase!) variables the ID (memory location) stays the same!

  You can use string interpolation to speed up printing vars:

    ans = 5 + 5
    puts "The answer is " + ans.to_s + "!"  # regular
    puts "The answer is #{ans}!"  #interpolated

  Instance variables are denoted with @ and are typically assigned inside #initialize:
    class Car
      def initialize(color)
        @color = color
      end

      def color
        @color
      end
    end

  Class Variables
    We can add a class variable @@num_wheels:
      class Car
        @@num_wheels = 4

        def initialize(color)
          @color = color
        end

        # getter for @color instance variable
        def color
          @color
        end

        # getter for @@num_wheels class variable
        def num_wheels
          @@num_wheels
        end
    end

    car_1 = Car.new("red")
    p car_1.num_wheels    # 4

    car_2 = Car.new("black")
    p car_2.num_wheels    # 4

LOOPS:
  keywords:
    break -> immideatly exit the loop
    next -> skip to next iteration of loop

METHODS:
  Use built-in methods:
    num = 6
    # Less preferred
    p num % 2 == 0
    # Preferred by a Rubyist
    p num.even?
    people = ["Joey", "Bex", "Andrew"]
    # Less preferred
    p people[people.length - 1]
    # Preferred by a Rubyist
    p people[-1]
    p people.last

  Useful methods/enums:
    enums: #times, #all?, #none?, #one?, #any?, #each, #select, #map
    arrays: #flatten, #include?, #max, #min, #count, #first, #last, #reverse
    strings: #split(""), #join(""), #length, #chars, #each_char, 
            #each_char.with_index, #reverse
    universal: #each_with_index

Blocks:
If you have a block call single method use:
["a", "b", "c"].map(&:upcase) #=> ["A", "B", "C"]  # => preffered
["a", "b", "c"].map { |str| str.upcase }  #=> ["A", "B", "C"] # => worse

Classes:
Importing classes:
  We import using "requre_relative":
    # project_root/pet_hotel.rb

    # Let's require the last two files, by specifying their path's relative to this pet_hotel.rb file
    require_relative "./cat.rb"
    require_relative "./other_animals/dog.rb"

Instance Methods:
  Dog#speak:
    Class Dog
      def speak
        "woof"
      end
    end

    my_dog = Dog.new("Fido", "woof")
    my_dog.speak          # "Fido says woof"

  Class Methods:
    Dog::growl:
      Class Dog
        self.growl
          "GRRRRR"
        end
      end

      Dog.growl   # Grrrrr

  Class#method_name means method_name is an instance method
  Class::method_name means method_name is a class method

  
Class Constants:
  NUM_WHEELS = 4
Class Variables:
  @@num_wheels = 4

an @instance_variable will be a distinct variable in each instance of a class; changing the variable will only effect that one instance
a @@class_variable will be shared among all instances of a class; changing the variable will effect all instances because all instances of the class
a CLASS_CONSTANT will be shared among all instances of a class, but cannot be changed

Creating a class:
    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end
    end

    cat_1 = Cat.new("Sennacy", "brown", 3)
    cat_2 = Cat.new("Whiskers", "white", 5)
    p cat_1 #<Cat:0x007fb6d804cfe0 @age=3, @color="brown", @name="Sennacy">
    p cat_2 #<Cat:0x007fb6d6bb60b8 @age=5, @color="white", @name="Whiskers">

  @ is how we denote a instance variable or attribute of our class. 
  That means that our cats will have the attributes or properties of @name, @color, @age.

  Getter Methods:
    instead of using full name : get_name , use the same name as attribute - def name

    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      def name
        @name
      end

      def age
        @age
      end
    end

  SETTER METHODS:
    class Cat
      def initialize(name, color, age)
        @name = name
        @color = color
        @age = age
      end

      # getter
      def age
        @age
      end

      # setter
      def age=(number)
        @age = number
      end
    end

RECURSION:
  A recursive method consists of two fundamental parts:

    the base case where we halt the recursion by not making a further call
    the recursive step where we continue the recursion by making another subsequent call

Shorter way to create setters and getters: attr_reader:

  Use them in the first line of class creation!  
  class Dog
    # attr_reader will define #name and #age getters for us
    attr_reader :name, :age

    # attr_writer will define #name= and #age= setters for us
    attr_writer :name, :age

    def initialize(name, age, favorite_food)
      @name = name
      @age = age
      @favorite_food = favorite_food
    end
  end
  
  If we want both reader and writer, we can use accessor method:
    class Dog
      # attr_accessor will define #name, #name=, #age, #age= methods for us
      attr_accessor :name, :age

      def initialize(name, age, favorite_food)
        @name = name
        @age = age
        @favorite_food = favorite_food
      end
    end

  Dont be thrown off by the syntax we use to call attr_reader. By convention in 
  Ruby, we omit the parentheses for attr methods. However, attr_reader :name, :age 
  is equivalent to the explicit attr_reader(:name, :age).

  Only use getters and setters for what you want to expose in your classes.

Symbols:
  str = "hello"   # the string 
  sym = :hello    # the symbol
  # Symbols are Immutable!!!
  Symbols as hash keys:
    my_bootcamp = { :name=>"App Academy", :color=>"red", :locations=>["NY", "SF", "ONLINE"] }
    p my_bootcamp           # => {:name=>"App Academy", :color=>"red", :locations=>["NY", "SF", "ONLINE"]}
    p my_bootcamp[:color]   #=> "red
    # shortcut:
    my_bootcamp = { name:"App Academy", color:"red", locations:["NY", "SF", "ONLINE"] }

Default Parameters:
  # By default, num will have the value of 1
  def repeat(message, num=1)
      message * num
  end
  p repeat("hi") # => "hi"
  p repeat("hi", 3) # => "hihihi"

Hashes:
  You can use :symbols as keys, and use a shortcut (skip => rocket):
    my_bootcamp = { name:"App Academy", color:"red", locations:["NY", "SF", "ONLINE"] }
    p my_bootcamp           # => {:name=>"App Academy", :color=>"red", :locations=>["NY", "SF", "ONLINE"]}
    p my_bootcamp[:color]   #=> "red

  enums: 
  If you have a method that accepts a hash as an argument,
  you can omit the braces when passing in the hash:
    def method(hash)
      p hash  # {"location"=>"SF", "color"=>"red", "size"=>100}
    end

    method({"location"=>"SF", "color"=>"red", "size"=>100})
    # this also works:
    method("location"=>"SF", "color"=>"red", "size"=>100)

    def modify_string(str, options={"upper"=>false, "repeats"=>1})
        str.upcase! if options["upper"]
        p str * options["repeats"]
    end

    modify_string("bye")   # => "bye"
    modify_string("bye", "upper"=>true, "repeats"=>3)   # => "BYEBYEBYE"

Splat operator:
  We use it when we want an unspecified amount of args;
  They will be stored in an array
  def method(arg_1, arg_2, *other_args)
    p arg_1         # "a"
    p arg_2         # "b"
    p other_args    # ["c", "d", "e"]
  end

  method("a", "b", "c", "d", "e") 

  We can also use it if we want to unpack an array/hash (with symbols ONLY!):
    arr_1 = ["a", "b"]
    arr_2 = ["d", "e"]
    arr_3 = [ *arr_1, "c", *arr_2 ]
    p arr_3 # => ["a", "b", "c", "d", "e"]

    old_hash = { a: 1, b: 2 }
    new_hash = { **old_hash, c: 3 }
    p new_hash # => {:a=>1, :b=>2, :c=>3}

  
Inject/reduce method:
  initial value of inject:
    array.inject(0) { |sum, ele| puts sum } # => 0
  Each block of code executed in (el) will go to acc  
  p [11, 7, 2, 4].inject { |acc, el| acc + el } # => 24
  p [11, 7, 2, 4].inject { |acc, el| acc * el } # => 616

Swapping  variables or elements of an array:
  array = ["a", "b", "c", "d"]    # let's swap "a" and "b"
  array[0], array[1] = array[1], array[0]
  p array         # => ["b", "a", "c", "d"]


METHODS/HASHES:
  You can omit braces when using hash as option:
    def modify_string(str, options={"upper"=>false, "repeats"=>1})
        str.upcase! if options["upper"]
        p str * options["repeats"]
    end

    modify_string("bye")   # => "bye"
    modify_string("bye", "upper"=>true, "repeats"=>3)   # => "BYEBYEBYE"

Scope:
  Blocks don't have their own scope, they are really a part of the containing method's scope.
  If's don't have their own scope too:
    if true
      drink = "cortado"
    end
    p drink
    
  Global Variables:
    Add '$' char before variable
    $message = "hello globe"
    def say_hello
        p $message
    endvariabl
    say_hello # => "hello globe"

    Ruby uses some by default: $PROGRAM_NAME, $stdin, $stdout

  Constants:
    # We create them by naming them in all caps, and we can't reassign them.
    # We can modify/mutate them though.
    FOOD = "pho"
    FOOD[0] = "P"
    p FOOD # => "Pho

    FOOD = "ramen"  #warning: already initialized constant FOOD
                    #warning: previous definition of FOOD was here

RSPEC:
  Example RSPEC:
    # /spec/prime_spec.rb
    require "prime"

    describe "prime? method" do
      it "should accept a number as an argument" do
        expect { prime?(7) }.to_not raise_error
      end

      context "when the number is prime" do
        it "should return true" do
          expect(prime?(7)).to eq(true)
          expect(prime?(11)).to eq(true)
          expect(prime?(13)).to eq(true)
        end
      end

      context "when the number is not prime" do
        it "should return false" do
          expect(prime?(4)).to eq(false)
          expect(prime?(9)).to eq(false)
          expect(prime?(20)).to eq(false)
          expect(prime?(1)).to eq(false)
        end
      end
    end

Exceptions:
  Once exception is reached, rescue block will execute, and program will continue
  You can also raise custom exceptions.
  "Raise" is how you bring up the exception, "Begin-rescue" is how you react to it
  You raise in a method, and use begin-rescue when calling a method

    def format_name(first, last)
      if !(first.instance_of?(String) && last.instance_of?(String))
        raise "arguments must be strings"
      end

      first.capitalize + " " + last.capitalize
    end

    first_name = 42
    last_name = true
    begin
      puts format_name(first_name, last_name)
    rescue
      # do stuff to rescue the "arguments must be strings" exception...
      puts "there was an exception :("
    end

Blocks:
  They can be either one-liners or multiline
    [1,2,3].map { |num| -(num * 2) } # => [-2, -4, -6]
	Blocks can accept parameters if we name them between pipes (|param_1, param_2, etc.|).
	
	When blocks uses a single method:
		good:
			["a", "b", "c"].map(&:upcase) #=> ["A", "B", "C"]
			[1, 2, 5].select(&:odd?)      #=> [1, 5]
		bad:
			["a", "b", "c"].map { |str| str.upcase }  #=> ["A", "B", "C"]
			[1, 2, 5].select { |num| num.odd? }       #=> [1, 5]
	We use & to convert this "method" into an object that we can pass into map.
	
Procs:
	A proc is an object that contains a block.
	We need procs because they allow us to save blocks to variables so we can manipulate them in our code.
  
  TL;DR what to use - if parameters are:
  &prc -> use a BLOCK ({ |ele| code_block })
  prc ->  a proc (Proc.new)


	doubler = Proc.new { |num| num * 2 }
	p doubler # #<Proc:0x00007f9a8b36b0c8>
	p doubler.call(5) # => 10
	p doubler.call(7) # => 14

	is_even = Proc.new do |num|
  if num % 2 == 0
			true 
		else
			false
  end
	end
	p is_even.call(12) # => true

	Passing Proc to a method:
		# Version 1: manual, proc accepting method
		def add_and_proc(num_1, num_2, prc)
			sum = num_1 + num_2
			p prc.call(sum)
		end

		doubler = Proc.new { |num| num * 2 }
		add_and_proc(1, 4, doubler)   # => 10

		# Version 2: automatic conversion from block to proc
		def add_and_proc(num_1, num_2, &prc)
			sum = num_1 + num_2
			p prc.call(sum)
		end

		add_and_proc(1, 4) { |num| num * 2 }  # => 10
	

	def my_method(&prc)
		# ...
	end

	# By looking at the parameter `&prc` we know that my_method must be passed a block,
	# because & denotes conversion from block to proc here:
	my_method { "I'm a block" }

	"&" converts blocks into procs, and procs into blocks.
	If method has a (&prc) parameter - it needs a block
	If method has a (prc) parameter - it needs a proc!
	example:
		doubler = Proc.new { |num| num * 2 }
		[1,2,3].map(&doubler) # => [2, 4, 6]

  
#HASHES:

  Access

  hash = { "name" => "App Academy", "color" => "red" }

  p hash["color"]  # prints "red"
  p hash["age"]    # prints nil

  k = "color"
  p hash[k]        # prints "red"

  hash["age"] = 5
  p hash           # prints {"name"=>"App Academy", "color"=>"red", "age"=>5}

  Checking Existence

  hash = { "name" => "App Academy", "color" => "red" }

  p hash.has_key?("name")             # prints true
  p hash.has_key?("age")              # prints false
  p hash.has_key?("red")              # prints false

  p hash.has_value?("App Academy")    # prints true
  p hash.has_value?(20)               # prints false
  p hash.has_value?("color")          # prints false

  Hash Enumerable Methods

  hash = { "name" => "App Academy", "color" => "red" }

  hash.each { |key, val| p key + ', ' + val} # prints
  # "name, App Academy"
  # "color, red"

  hash.each_key { |key| p key } # prints
  # "name"
  # "color"

  hash.each_value { |val| p val } # prints
  # "App Academy"
  # "red"

  Hash.new

    plain_hash = { }
    plain_hash["city"] = "SF"
    p plain_hash["city"]    # prints "SF"
    p plain_hash["country"] # prints nil

    hash_with_default = Hash.new("???")
    hash_with_default["city"] = "NYC"
    p hash_with_default["city"]    # prints "NYC"
    p hash_with_default["country"] # prints "???"


  Byebug Cheatsheet

  before running your file
      require "byebug" - add to the top of your file to gain access to the gem
      debugger - place this line at a point in your file where you want to begin debugger mode
  while in debugger mode
      l <start line>-<end line> - list the line numbers in the specified range
          example: l 3-20
      step or s - step into the method call on the current line, if possible
      next or n - move to the next line of executed code
      break <line num> or b <line num> - place a breakpoint at the specified line number, this will pause execution again
      continue or c - resume normal execution of the code until a breakpoint
      display <variable> - automatically show the current value of a variable



User Input:
  To get user input we use ::gets method, but watch out - it contains newline "\n"
  To fix this we use String#chomp:

    my_string = "yes\n"
    p my_string       # "yes\n"
    p my_string.chomp # "yes"

  To convert user input into numbers etc. :
    gets.to_i

OOP (Object Oriented Programming) principles:
  Encapsulation:
    For us, the goal of encapsulation is to give users access to the things that 
    are safe for them to use. Some data we may choose to keep private or purposefully
    hide from outside users for the sake of security. One common way to encapsulate
    data attributes is by making them only accessible through methods that we 
    explicitly design as programmers!
  Abstraction:
    In OOP, abstraction is the process of exposing essential features of an object 
    while hiding inner details that are not necessary to using the feature.

Syntactic Sugar:
  The broad name for code or syntax that is a "shortcut" for other code
    class Queue
      def initialize
        @line = []
      end

      def [](position)
        @line[position]
      end

      def []=(position, ele)
        @line[position] = ele
      end

      def add(ele)
        @line << ele # add ele to back of line
        nil
      end

      def remove
        @line.shift  # remove front ele of line
      end
    end

    grocery_checkout = Queue.new
    grocery_checkout.add("Alan")
    grocery_checkout.add("Alonzo")

    # Let's call Queue#[]= without syntactic sugar:
    grocery_checkout.[]=(0, "Grace")
    p grocery_checkout    #<Queue:0x007fe7a7a29ec8 @line=["Grace", "Alonzo"]>

    # Let's call Queue#[]= again, but with syntactic sugar:
    grocery_checkout[1] = "Grace"
    p grocery_checkout    #<Queue:0x007fe7a7a29ec8 @line=["Grace", "Grace"]>

TRUTHY, FALSEY VALUES:
  Falsey values - nil and false
  Truthy - every other value
  Here is a more complete description of how a || b behaves under the hood:

    when a is truthy, return a
    when a is falsey, return b

true || 42          # => true
42 || true          # => 42
false || 42         # => 42
42 || false         # => 42
false || "hello"    # => "hello"
nil || "hello"      # => "hello"
"hi" || "hello"     # => "hi"
0 || true           # => 0
false || nil        # => nil

We can write a ||= b in place of a = a || b :

  def greet(person = nil)
      person ||= "you"
      p "Hey " + person
  end

  greet("Brian")  # => "Hey Brian"
  greet           # => "Hey you"



Default Procs:
  The ||= pattern is utilized heavily when implementing default procs:

  def call_that_proc(val, &prc)
      prc ||= Proc.new { |data| data.upcase + "!!" }
      prc.call(val)
  end

  p call_that_proc("hey")                                             # => "HEY!!"
  p call_that_proc("programmers") { |data| data * 3 }                 # => "programmersprogrammersprogrammers"
  p call_that_proc("code") { |data| "--" + data.capitalize + "--"}    # => "--Code--"

  You'll notice that in the above code, we don't explicitly assign prc to be nil. 
  This is because prc will automatically contain nil if the method is called without passing in a proc.

  Lazy Initialization

The ||= pattern is also useful when implementing Lazy Initialization for classes. Lazy initialization is a design strategy where we delay creation of an object until it is needed. The idea is to avoid slow or costly operations until they are absolutely necessary. This contrasts with our typical classes that preemptively set all attributes up front. For example, take this Restaurant class that initializes all attributes immediately:

class Restaurant
    attr_accessor :name, :chefs, :menu

    def initialize(name, chefs)
        @name = name
        @chefs = chefs
        @menu = ["sammies", "big ol' cookies", "bean blankies", "chicky catch", "super water"]
    end
end

five_star_restaurant = Restaurant.new("Appetizer Academy", ["Marta", "Jon", "Soon-Mi"])
p five_star_restaurant
#<Restaurant:0x00007fea7a8c6880 
# @name="Appetizer Academy", 
# @chefs=["Marta", "Jon", "Soon-Mi"],
# @menu=["sammies", "big ol' cookies", "bean blankies", "chicky catch", "super water"]
#>

While it is required that @name and @chefs must be assigned 
immediately in Restaurant#initialize 
since they are taken in as arguments, it is not necessary that @menu be assigned
 immediately. Imagine that @menu was a "costly" object like an array of 10,000
  elements. Initializing @menu may slow down the creation of the Restaurant. To 
  overcome this, we'll use the lazy initialization pattern to only create the 
  @menu if someone asks for it. In other words, we'll create the @menu in the 
  Restaurant#menu getter if it does not exist already:

class Restaurant
    attr_accessor :name, :chefs, :menu

    def initialize(name, chefs)
        @name = name
        @chefs = chefs
    end

    def menu
        @menu ||= ["sammies", "big ol' cookies", "bean blankies", "chicky catch", "super water"]
    end
end

five_star_restaurant = Restaurant.new("Appetizer Academy", ["Marta", "Jon", "Soon-Mi"])

p five_star_restaurant
#<Restaurant:0x00007f90b3922368 
# @name="Appetizer Academy",
# @chefs=["Marta", "Jon", "Soon-Mi"]
#>

p five_star_restaurant.menu
#["sammies", "big ol' cookies", "bean blankies", "chicky catch", "super water"]

p five_star_restaurant
#<Restaurant:0x00007f90b3922368
# @name="Appetizer Academy", 
# @chefs=["Marta", "Jon", "Soon-Mi"],
# @menu=["sammies", "big ol' cookies", "bean blankies", "chicky catch", "super water"]
#>

Above, notice how the restaurant lacks a @menu until we call the getter!
 To accomplish this we leveraged the fact that a missing attribute will be nil. That means we can use the ||= pattern!