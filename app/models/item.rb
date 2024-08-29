class Item < ApplicationRecord
  has_many :inventories
  has_many :players, through: :inventories
  has_one_attached :image

  validates :name, :description, :health_bonus, :strength_bonus, :item_type, presence: true
  validates :item_type, inclusion: { in: ['weapon', 'hat', 'shield'] }

  validates :name, :description, :item_type, presence: true
  validates :health_bonus, :strength_bonus, :experience_bonus, numericality: { only_integer: true, allow_nil: true }
end
