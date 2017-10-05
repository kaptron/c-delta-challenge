require 'rails_helper'

describe QuestionChoice do
  context 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:creative_quality) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :question }
    it { is_expected.to validate_presence_of :creative_quality }
    it { is_expected.to validate_numericality_of :score }
  end

  describe '#color' do
    let(:question_choice) { QuestionChoice.new }

    it 'returns "success" for positive scores' do
      question_choice.score = 5
      expect(question_choice.color).to eql('success')
    end

    it 'returns "danger" for negative scores' do
      question_choice.score = -5
      expect(question_choice.color).to eql('danger')
    end
  end
end
