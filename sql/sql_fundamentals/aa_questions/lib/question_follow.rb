require "sqlite3"
require_relative "questionsDatabase"

class QuestionFollow

  attr_accessor :id, :user_id, :question_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end

  def self.all
    question_follows = QuestionsDatabase.instance.execute("SELECT * FROM question_follows;")
    question_follows.map { |questionFollow| QuestionFollow.new(questionFollow) }
  end  

  def self.find_by_id(id)
    question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
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
end