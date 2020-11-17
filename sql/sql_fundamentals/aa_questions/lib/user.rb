require "sqlite3"
require_relative "questions_database"
require_relative "question"
require_relative "question_like"

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

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  # return average number of likes per post
  # Looked up the solution, and worked alongside it to implement it
  def average_karma
    QuestionsDatabase.get_first_value(<<-SQL, self.id)
      SELECT
        CAST(COUNT(question_likes.id) AS FLOAT) / 
          COUNT(DISTINCT(questions.id)) AS avg_karma
      FROM
        questions
      LEFT JOIN
        question_likes
      ON
        question_likes.question_id = questions.id
      WHERE
        questions.author_id = ?
    SQL
  end
end