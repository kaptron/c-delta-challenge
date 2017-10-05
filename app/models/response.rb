class Response < ApplicationRecord
  has_many :question_responses

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :count, to: :question_responses, prefix: true

  def display_name
    "#{first_name} #{last_name}"
  end

  def completed?
    question_responses_count == Question.count
  end

  def qualities
    results = []
    CreativeQuality.find_each do |creative_quality|
      qrs = question_responses
        .includes(question_choice: [:creative_quality, :question])
        .where('question_choices.creative_quality_id' => creative_quality.id)
      max_score = qrs.collect { |qr| qr.question.max_score }.sum
      min_score = qrs.collect { |qr| qr.question.min_score }.sum
      raw_score = qrs.collect { |qr| qr.question_choice.score }.sum
      max = (min_score.abs + max_score).to_f
      max = 1.0 if max.zero?
      normalized_score = ((min_score.abs + raw_score).to_f / max) * 100.0
      result = {
        creative_quality_id: creative_quality.id,
        name: creative_quality.name,
        min_score: min_score,
        max_score: max_score,
        raw_score: raw_score,
        normalized_score: normalized_score.round,
      }
      results << result
    end
    results
  end
end
