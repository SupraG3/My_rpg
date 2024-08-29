class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :level
      t.integer :experience
      t.integer :health
      t.integer :strength

      t.timestamps
    end
  end
end
