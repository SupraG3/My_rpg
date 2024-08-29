class AddManualPointsToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :manual_health_points, :integer
    add_column :players, :manual_strength_points, :integer
  end
end
