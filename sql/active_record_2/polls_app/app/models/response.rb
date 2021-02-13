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

  # Returns other Responses objects for the same Question
  def sibling_responses
    self
    .question
    .responses
    .where.not(id: self.id)
  end
  
  def respondent_already_answered?
    self
    .sibling_responses
    .where(user_id: self.user_id)
    .exists?
  end
end

def not_duplicate_response
  if respondent_already_answered?
    errors[:respondent] << 'Cannot create multiple responses to the same Question'
  end
end