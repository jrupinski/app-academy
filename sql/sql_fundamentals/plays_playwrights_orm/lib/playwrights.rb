require_relative "plays"

class Playwright
  def initialize(options)
    @id = options["id"]
    @name = options["name"]
    @birth_year = options["birth_year"]
  end

  def self.all
    playwrights = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    playwrights.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    playwrights = PlayDBConnection.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        playwrights
      WHERE
        name LIKE '#{name}';
    SQL
  end

  def create
    # TODO
  end

  def update
    # TODO
  end

  # returns all plays written by playwright
  def get_plays
    # TODO
  end
end