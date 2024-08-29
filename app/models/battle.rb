class Battle < ApplicationRecord
    belongs_to :player
    belongs_to :quest
  
    after_initialize :set_initial_values
  
    def set_initial_values
      self.player_health ||= player.total_health
      self.opponent_health ||= player.get_base_health
      self.current_turn ||= 1
      self.status ||= 'in_progress'
    end
  
    def player_attack
      damage = calculate_damage(player.total_strength)
      self.opponent_health -= damage
      save
      check_victory_or_defeat
      next_turn if status == 'in_progress'
    end
  
    def opponent_attack
      damage = calculate_damage(player.get_base_strength)
      self.player_health -= damage
      save
      check_victory_or_defeat
      next_turn if status == 'in_progress'
    end
  
    def calculate_damage(strength)
      (strength / 4).round
    end
  
    def check_victory_or_defeat
      if opponent_health <= 0
        player_wins
      elsif player_health <= 0
        player_loses
      end
    end
  
    def player_wins
      quest.complete_quest(player)
      update(status: 'won')
    end
  
    def player_loses
      update(status: 'lost')
    end
  
    def next_turn
      self.current_turn += 1
      save
    end
  end
  