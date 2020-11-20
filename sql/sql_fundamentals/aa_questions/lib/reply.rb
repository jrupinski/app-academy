require "sqlite3"
require_relative "questions_database"
require_relative "model_base"

class Reply < ModelBase

  attr_accessor :id, :user_id, :question_id, :question_subject, :question_body, :parent_reply_id

  def initialize(options)
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
    @question_subject = options["question_subject"]
    @question_body = options["question_body"]
    @parent_reply_id = options["parent_reply_id"]
  end

  def self.find_by_user_id(user_id)
    replies_data = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?;
    SQL

    return nil if replies_data.empty?
    replies_data.map { |reply_data| Reply.new(reply_data) }
  end
  
  def self.find_by_question_id(question_id)
    replies_data = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil if replies_data.empty?
    replies_data.map { |reply_data| Reply.new(reply_data) }
  end

  def self.find_by_parent_id(parent_reply_id)
    replies_data = QuestionsDatabase.execute(<<-SQL, parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    return nil if replies_data.empty?
    replies_data.map { |reply_data| Reply.new(reply_data) }
  end

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_id(self.question_id)
  end

  def parent_reply
    Reply.find_by_id(self.parent_reply_id)
  end

  def child_replies
    Reply.find_by_parent_id(self.id)
  end

  def save
    # If record doesn't exists - save it
    if self.id.nil?
      QuestionsDatabase.execute(<<-SQL, self.user_id, self.question_id, self.question_subject, self.question_body, self.parent_reply_id)
        INSERT INTO
          replies(user_id, question_id, parent_reply_id, question_subject, question_body)
        VALUES
          (?, ?, ?, ?, ?);
      SQL

      "#{self} inserted into database"
    else  # update if it exists in DB
      QuestionsDatabase.execute(<<-SQL, self.user_id, self.question_id, self.question_subject, self.question_body, self.parent_reply_id, self.id)
        UPDATE
          replies
        SET
          user_id = ?, question_id = ?, question_subject = ?, question_body = ?, parent_reply_id = ?
        WHERE
          id = ?;
      SQL
      
      "#{self} row updated in database"
    end
  end
end 