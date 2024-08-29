class Inventory < ApplicationRecord
  belongs_to :player
  belongs_to :item
  validates :equipped, inclusion: { in: [true, false] }
end
