class Player < ApplicationRecord
  belongs_to :user
  has_many :inventories, dependent: :destroy
  has_many :items, through: :inventories

  before_create :set_initial_stats

  def equip(item)
    inventory_item = inventories.find_by(item: item)
    if inventory_item
      inventory_item.update(equipped: true)
      apply_item_bonuses
    end
  end

  def unequip(item)
    inventory_item = inventories.find_by(item: item)
    if inventory_item
      inventory_item.update(equipped: false)
      apply_item_bonuses
    end
  end

  def equipped_items
    items.where(inventories: { equipped: true })
  end

  def available_items
    items.where(inventories: { equipped: false })
  end

  def apply_item_bonuses
    self.health = total_health
    self.strength = total_strength

    save(validate: false)
  end

  def total_health
    base_health + manual_health_points.to_i + equipped_items.sum(:health_bonus)
  end

  def total_strength
    base_strength + manual_strength_points.to_i + equipped_items.sum(:strength_bonus)
  end

  def level_up
    self.level_up_points ||= 0
    self.level += 1
    self.level_up_points += 10
    save
  end

  def allocate_points(health_points, strength_points)
    self.level_up_points ||= 0
    if health_points < 0 || strength_points < 0
      errors.add(:base, "You can't allocate negative points.")
      return false
    elsif health_points + strength_points <= self.level_up_points
      self.manual_health_points ||= 0
      self.manual_strength_points ||= 0
      self.manual_health_points += health_points
      self.manual_strength_points += strength_points
      self.level_up_points -= (health_points + strength_points)
      apply_item_bonuses
      save
      return true
    else
      errors.add(:base, "You don't have enough points to allocate.")
      return false
    end
  end

  def gain_experience(amount)
    self.experience += amount
    while self.experience >= experience_to_next_level
      self.experience -= experience_to_next_level
      level_up
    end
    save
  end

  def experience_to_next_level
    20 * level
  end

  def get_base_health
    base_health
  end

  def get_base_strength
    base_strength
  end

  private

  def base_health
    10
  end

  def base_strength
    10
  end

  def set_initial_stats
    self.points = 0
    self.level_up_points = 0
    self.level = 1
    self.experience = 0
    self.health = base_health
    self.strength = base_strength
    self.manual_health_points = 0
    self.manual_strength_points = 0
  end
end
