require "sqlite3"
require_relative "questions_database"
require_relative "question"

class User

  attr_accessor :id, :fname, :lname

  def initialize(options)
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def self.all
    users = QuestionsDatabase.execute("SELECT * FROM users;")
    users.map { |user| User.new(user) }
  end  

  def self.find_by_id(id)
    user = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?;
    SQL

    User.new(user)
  end

  def self.find_by_name(fname, lname)
    users = QuestionsDatabase.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?;
    SQL

    return nil if users.empty?
    users.map { |user| User.new(user) }
  end

  # Return all questions asked by User
  def authored_questions
    Question.find_by_author_id(self.id)
  end

  # Return all replies asked by User
  def authored_replies
    Reply.find_by_user_id(self.id)
  end
end