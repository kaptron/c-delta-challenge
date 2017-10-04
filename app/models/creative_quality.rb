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
end
