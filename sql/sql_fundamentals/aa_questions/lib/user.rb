require "sqlite3"
require_relative "questionsDatabase"

class User

  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def self.all
    users = QuestionsDatabase.instance.execute("SELECT * FROM users;")
    users.map { |user| User.new(user) }
  end  

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL

    User.new(user)
  end
end