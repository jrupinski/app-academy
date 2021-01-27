def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  
  Movie
    .joins(:actors)
    .select(:id, :title)
    .where(actors: { name: those_actors })
    .group(:id)
    # num of actors from "those actors" is the same as the amount of those actors found in a movie
    .having('COUNT(*) = ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select("(yr / 10) * 10 AS decade")
    .group(:decade)
    .order('AVG(score) DESC')
    .first
    .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  starred_movies = Movie
    .select(:id)
    .joins(:actors)
    .where(actors: { name: name })
  
  Actor
    .joins(:movies)
    .where.not(name: name)
    .where(movies: { id: starred_movies })
    .distinct
    .pluck(:name)

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_joins(:movies)
    .where(movies: { id: nil })
    .count(:id)

end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  chars = whazzername.chars
  regex_find_chars = "%#{chars.join('%')}%"

  Movie
    .joins(:actors)
    .where('LOWER(actors.name) LIKE ?', regex_find_chars.downcase)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  
end
