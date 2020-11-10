require "sqlite3"
require_relative "questions_database"
require_relative "user"

class QuestionFollow

  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.all
    question_follows = QuestionsDatabase.execute("SELECT * FROM question_follows;")
    question_follows.map { |questionFollow| QuestionFollow.new(questionFollow) }
  end  

  def self.find_by_id(id)
    question_follows = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?;
    SQL

    return nil if question_follows.empty?
    QuestionFollow.new(question_follows.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows
      ON 
        users.id = question_follows.user_id
      WHERE
        question_follows.question_id = ?
    SQL

    return nil if followers.empty?
    followers.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows
      ON 
        questions.id = question_follows.question_id
      WHERE
        question_follows.user_id = ?
    SQL

    return nil if questions.empty?
    questions.map { |question| Question.new(question) }
  end

end