require "sqlite3"
require_relative "questionsDatabase"

class Question

  attr_accessor :id, :author_id, :title, :body

  def initialize(options)
    @id = options["id"]
    @author_id = options["author_id"]
    @title = options["title"]
    @body = options["body"]
  end

  def self.all
    questions = QuestionsDatabase.instance.execute("SELECT * FROM questions;")
    questions.map { |question| Question.new(question) }
  end  

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?;
    SQL

    Question.new(question)
  end

  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.get_first_row(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?;
    SQL

    Question.new(question)
  end
end