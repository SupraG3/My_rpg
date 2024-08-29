class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.references :player, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.boolean :equipped

      t.timestamps
    end
  end
end
