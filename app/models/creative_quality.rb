class CreativeQuality < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :color, presence: true, uniqueness: true

  before_validation :assign_random_color, on: :create

  def self.taken_colors
    all.collect(&:color).uniq
  end

  def assign_random_color
    taken = self.class.taken_colors
    self.color = BootstrapColorService.new(taken: taken).random_available_color
  end

  def average_score
    Rails.cache.fetch "cq-avg-score-#{id}" do
      total = []
      Response.find_each do |response|
        q = response.qualities.find { |q| q[:creative_quality_id] == self.id }
        total << q[:normalized_score]
      end
      return 0 if total.empty?
      total.sum / total.count
    end
  end
end
