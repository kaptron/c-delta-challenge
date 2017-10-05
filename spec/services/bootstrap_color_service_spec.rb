require 'rails_helper'

describe BootstrapColorService do
  describe '.assign_random_available_color' do
    it 'should return one of the remaining colors by default' do
      color_service = BootstrapColorService.new
      expect(BootstrapColorService::COLORS).to include(color_service.random_available_color)
    end

    it 'should return the last available color if only one is left' do
      taken = %w[primary success info danger]
      color_service = BootstrapColorService.new(taken: taken)
      expect(color_service.random_available_color).to eql('warning')
    end
  end
end
