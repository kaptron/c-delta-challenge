require 'rails_helper'

describe Question do
  let(:question) do
    choices = build_list(:question_choice, 5, score: 3)
    choices.first.score = -2
    choices.last.score = 4
    Question.new(title: 'My Question', choices: choices)
  end

  context 'associations' do
    it { is_expected.to have_many(:choices) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :title }
  end

  describe '#max_score' do
    it 'gets the maximum score out of the choices' do
      expect(question.max_score).to eql(4)
    end
  end

  describe '#min_score' do
    it 'gets the minimum score out of the choices' do
      expect(question.min_score).to eql(-2)
    end
  end
end
