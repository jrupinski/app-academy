# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice 

  has_many :responses,
    through: :answer_choices,
    source: :responses

  # Return a hash of Question's answer choices, and count of the replies
  def results_n_plus_1
    results = {}
    # n + 1 query
    choices = self.answer_choices

    choices.each do |answer_choice|
      answer_responses = answer_choice.responses
      results[answer_choice.text] = answer_responses.count
    end

    results
  end

  # Return a hash of Question's answer choices, and count of the replies
  # Optimized version that uses ActiveDirectory's prefetching with #includes
  def results_2_queries
    results = {}
    # prefetch - n query version
    choices = self.answer_choices.includes(:responses)

    choices.each do |answer_choice|
      answer_responses = answer_choice.responses
      results[answer_choice.text] = answer_responses.length
    end

    results
  end

  # Return a hash of Question's answer choices, and count of the replies
  # This version uses ActiveDirectory, transfers only relevant info to end user.
  # Instead of caching ALL responses like in #results_2_queries, it fetches answer choices' text with their count only.
  def results_single_query
    results = {}

    choices = self.answer_choices
      # left outer join because 0 counts is also a valid result 
      .left_outer_joins(:responses)
      .select(:text, 'COUNT(responses.id) AS num_responses')
      .where('answer_choices.question_id = ?', self.id)
      .group(:id)

    # convert results into a hash
    choices.each do |answer_choice|
      results[answer_choice.text] = answer_choice.num_responses
    end

    results
  end
end

