class QuestionChoice < ApplicationRecord
  belongs_to :question, inverse_of: :choices
  belongs_to :creative_quality

  validates :text, presence: true
  validates :question, presence: true
  validates :creative_quality, presence: true
  validates :score, numericality: { only_integer: true }

  def color
    score >= 0 ? 'success' : 'danger'
  end
end
