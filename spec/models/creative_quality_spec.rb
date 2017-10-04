require 'rails_helper'

describe CreativeQuality do
  context 'validations' do
    CreativeQuality.skip_callback :validation, :before, :assign_random_color
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:color) }
    it { is_expected.to validate_uniqueness_of(:color) }
  end

  describe '#assign_random_color' do
    let(:creative_quality) { CreativeQuality.new }

    it 'assigns one of the available colors' do
      creative_quality.assign_random_color
      expect(creative_quality.color).to be_instance_of(String)
    end
  end
end
