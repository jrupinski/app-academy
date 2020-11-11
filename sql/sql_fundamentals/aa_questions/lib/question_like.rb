require "sqlite3"
require_relative "questions_database"
require_relative "question"

class QuestionLike

  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.all
    question_likes = QuestionsDatabase.execute("SELECT * FROM question_likes;")
    question_likes.map { |question_like| QuestionLike.new(question_like) }
  end  

  def self.find_by_id(id)
    question_likes = QuestionsDatabase.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?;
    SQL

    return nil if question_likes.empty?
    QuestionLike.new(question_likes.first)
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes
      ON
        questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL

    return nil if questions.empty?
    questions.map { |question| Question.new(question) }
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes
      ON
        users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?;
    SQL

    return nil if likers.empty?
    likers.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    QuestionsDatabase.get_first_value(<<-SQL, question_id)
      SELECT
        COUNT(*) AS likes
      FROM
        question_likes
      JOIN
        questions
      ON
        question_likes.id = questions.id
      WHERE
        question_likes.question_id = ?
    SQL
  end
end