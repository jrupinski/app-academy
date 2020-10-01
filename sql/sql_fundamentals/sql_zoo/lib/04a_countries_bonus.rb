# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      countries.name
    FROM
      countries
    WHERE countries.gdp > (
      SELECT
        MAX(COALESCE(gdp, 0)) AS max_gdp
      FROM
        countries AS other_country
      WHERE
        other_country.continent = 'Europe'
    )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      c1.continent, c1.name, c1.area
    FROM
      countries AS c1
    WHERE
      c1.area IN (
        SELECT
          MAX(c2.area)
        FROM
          countries AS c2
        WHERE
          c1.continent = c2.continent
    )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      big_country.name, big_country.continent
    FROM
      countries AS big_country
    WHERE big_country.population > 3 * (
      SELECT
        MAX(neighbour_country.population) AS largest_neighbour
      FROM
        countries AS neighbour_country
      WHERE
        big_country.name != neighbour_country.name
      AND
        big_country.continent = neighbour_country.continent
    )
  SQL
end
