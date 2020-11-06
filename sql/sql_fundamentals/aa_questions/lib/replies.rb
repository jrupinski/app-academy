require "sqlite3"
require_relative "questionsDatabase"

class Reply

  # TODO: add queries for returning each datum properly (SELECT queries) 
  attr_accessor :id, :user_id, :question_id, :question_subject, :question_body, :parent_reply_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
    @question_subject = options["question_subject"]
    @question_body = options["question_body"]
    @parent_reply_id = options["parent_reply_id"]
  end

  def self.all
    questions = QuestionsDatabase.instance.execute("SELECT * FROM questions;")
    questions.map { |question| Reply.new(question) }
  end  

  def self.find_by_id(id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL

    return nil if questions.empty?
    Reply.new(questions.first)
  end
end