class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.references :quest, null: false, foreign_key: true
      t.text :description
      t.integer :order

      t.timestamps
    end
  end
end
