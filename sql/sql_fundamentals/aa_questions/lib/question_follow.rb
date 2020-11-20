require "sqlite3"
require_relative "questions_database"
require_relative "user"
require_relative "model_base"

class QuestionFollow < ModelBase

  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
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

  # Fetches the n most followed questions.
  def self.most_followed_questions(n = 1)
    questions = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows
      ON
        questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT ?;
    SQL

    return nil if questions.empty?
    questions.map { |question| Question.new(question) }
  end
end