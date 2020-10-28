require_relative "plays"

class Playwright
  attr_accessor :id, :name, :birth_year

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name LIKE ?
    SQL

    # person is an array of query results, but we only want the first result
    # one liner:
    # person.empty? ? nil : Playwright.new(person.first)
    # cleaner version:
    return nil if person.empty?
    Playwright.new(person.first)
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
        playwrights(name, birth_year)
      VALUES
        (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id

    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year, self.id)
      UPDATE
        playwrights
      SET
        name = ?,
        birth_year = ?
      WHERE
        id = ?
    SQL
  end

  # returns all plays written by playwright
  def get_plays
    plays = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        *
      FROM
        playwrights
      JOIN
        plays ON playwrights.id = plays.playwright_id
      WHERE
        playwrights.name LIKE ?
    SQL

    plays.map { |play| Play.new(play) }
  end
end