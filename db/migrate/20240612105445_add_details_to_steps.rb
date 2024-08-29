class AddDetailsToSteps < ActiveRecord::Migration[7.1]
  def change
    add_column :steps, :question, :string
    add_column :steps, :correct_answer, :string
    add_column :steps, :wrong_answer, :string
    add_column :steps, :reward_item_id, :integer
  end
end
