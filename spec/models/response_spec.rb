require 'rails_helper'

describe Response do
  context 'associations' do
    it { is_expected.to have_many(:question_responses) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end

  describe '#display_name' do
    let(:response) { Response.new(first_name: 'Tal', last_name: 'Safran') }

    it 'concatenates the first and last name' do
      expect(response.display_name).to eql('Tal Safran')
    end
  end

  describe '#qualities' do
    let(:response) { build(:response) }
    let(:qualities) { response.qualities }

    before do
      # will build a unique creative_quality per response
      response.question_responses = build_list(:question_response, 3)
    end

    it 'gets a list of scores per creative quality' do
      expect(qualities.count).to eql(3)
    end

    it 'gets a min and max score per creative quality' do
      quality = qualities.first
      expect(quality[:min_score]).to be <= quality[:max_score]
    end

    it 'gets a normalized score between 0 and 100' do
      quality = qualities.first
      expect(quality[:normalized_score]).to be <= 100
      expect(quality[:normalized_score]).to be >= 0
    end
  end

  describe '#completed?' do
    let(:response) { Response.new }

    before do
      allow(Question).to receive(:count).and_return(3)
      allow(response).to receive_message_chain(:question_responses, :count)
        .and_return(response_count)
    end

    context 'when no responses exist' do
      let(:response_count) { 0 }
      it 'is false' do
        expect(response.completed?).to be(false)
      end
    end

    context 'when some responses exist' do
      let(:response_count) { 1 }
      it 'is false' do
        expect(response.completed?).to be(false)
      end
    end

    context 'when responses exist for all questions' do
      let(:response_count) { 3 }
      it 'is true' do
        expect(response.completed?).to be(true)
      end
    end
  end
end
