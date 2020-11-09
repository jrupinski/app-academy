require "sqlite3"
require_relative "questionsDatabase"
require_relative "user"
require_relative "reply"

class Question

  attr_accessor :id, :author_id, :title, :body

  def initialize(options)
    @id = options["id"]
    @author_id = options["author_id"]
    @title = options["title"]
    @body = options["body"]
  end

  def self.all
    questions = QuestionsDatabase.execute("SELECT * FROM questions;")
    questions.map { |question| Question.new(question) }
  end  

  def self.find_by_id(id)
    question = QuestionsDatabase.get_first_row(<<-SQL, id)
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
    questions = QuestionsDatabase.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?;
    SQL

    return nil if questions.empty?
    questions.map { |question| Question.new(question) }
  end

  def author
    User.find_by_id(self.author_id)
  end

  def replies
    Reply.find_by_user_id(self.author_id)
  end
end