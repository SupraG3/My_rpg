class CreateNpcs < ActiveRecord::Migration[7.1]
  def change
    create_table :npcs do |t|
      t.string :name
      t.integer :health
      t.integer :strength
      t.string :avatar

      t.timestamps
    end
  end
end
