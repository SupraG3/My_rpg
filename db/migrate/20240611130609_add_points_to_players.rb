class AddPointsToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :points, :integer
    add_column :players, :level_up_points, :integer
  end
end
