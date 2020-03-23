# PHASE 2
def convert_to_int(str)
  Integer(str)
  rescue ArgumentError
    puts "This is not a valid number"
    nil
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class NotAFruitError < StandardError
  def message
    "This is not a fruit. Conversation over."
  end
end

class CoffeeError < StandardError
  def message
    "Thanks for coffee, I really needed it. Go ahead, try again."
  end
end


def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit.downcase == "coffee"
    raise CoffeeError
  else 
    raise NotAFruitError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotAFruitError => e
    puts e.message
  end
end  

# PHASE 4
# class FriendshipTooShortError < StandardError
#   def message
#     "Friendship too short. Minimum duration: 5 years."
#   end
# end

# class NameMissingError < StandardError; end
# class FavPastimeMissingError < StandardError; end


class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("Name cannot be empty!") if name.empty?
    raise ArgumentError.new("Friendship too short. Minimum duration: 5 years.") if yrs_known < 5
    raise ArgumentError.new("Favorite pastime cannot be empty!") if fav_pastime.empty?

    @name = name 
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


