class Quest < ApplicationRecord
  has_many :steps, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true

  def complete_quest(player)
    player.gain_experience(50)
    steps.each do |step|
      if step.reward_item
        inventory_item = player.inventories.find_or_initialize_by(item: step.reward_item)
        inventory_item.equipped = false
        inventory_item.save!
      end
    end
  end
end
