class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :health_bonus
      t.integer :strength_bonus
      t.integer :experience_bonus
      t.string :item_type

      t.timestamps
    end
  end
end
