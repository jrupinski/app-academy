require "sqlite3"
require_relative "questions_database"
require_relative "user"
require_relative "reply"
require_relative "question_like"

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

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked_question
    QuestionLike.most_liked_questions(1).first
  end

  def author
    User.find_by_id(self.author_id)
  end

  def replies
    Reply.find_by_user_id(self.author_id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_of_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

  def save
    # If record doesn't exists - save it
    if self.id.nil?
      QuestionsDatabase.execute(<<-SQL, self.author_id, self.title, self.body)
        INSERT INTO
          questions(author_id, title, body)
        VALUES
          (?, ?, ?);
      SQL
    else  # update if it exists in DB
      QuestionsDatabase.execute(<<-SQL, self.author_id, self.title, self.body, self.id)
        UPDATE
          questions
        SET
          author_id = ?, title = ?, body = ?
        WHERE
          id = ?;
      SQL
    end
  end
end