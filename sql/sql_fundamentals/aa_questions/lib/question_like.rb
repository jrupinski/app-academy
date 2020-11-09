require "sqlite3"
require_relative "questionsDatabase"

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
end