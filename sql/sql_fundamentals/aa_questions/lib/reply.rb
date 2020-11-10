require "sqlite3"
require_relative "questions_database"

class Reply

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
    replies = QuestionsDatabase.execute("SELECT * FROM replies;")
    replies.map { |reply| Reply.new(reply) }
  end  

  def self.find_by_id(id)
    reply_data = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?;
    SQL

    Reply.new(reply_data)
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
end 