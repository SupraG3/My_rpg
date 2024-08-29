class CreateBattles < ActiveRecord::Migration[7.1]
  def change
    create_table :battles do |t|
      t.integer :player_id
      t.integer :quest_id
      t.integer :player_health
      t.integer :opponent_health
      t.integer :current_turn

      t.timestamps
    end
  end
end
