class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
