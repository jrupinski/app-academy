# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validate :not_duplicate_response

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  # Returns other Responses objects for the same Question
  def sibling_responses
    self
    .question
    .responses
    .where.not(id: self.id)
  end

  # Check if respondent answered already in another Reply object
  def respondent_already_answered?
    self
    .sibling_responses
    .where(user_id: self.user_id)
    .exists?
  end

  # Validate that there is only one answer from every respondent
  def not_duplicate_response
    if respondent_already_answered?
      errors[:respondent] << 'Cannot create multiple responses to the same Question'
    end
  end

  # Check if Reply's respondent is the author of the poll that the question's reply belongs to.
  def respondent_is_poll_author?
    poll_author = self
      .poll
      .author

    poll_author.id == self.user_id
  end
end