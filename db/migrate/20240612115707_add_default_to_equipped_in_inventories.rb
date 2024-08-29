class AddDefaultToEquippedInInventories < ActiveRecord::Migration[6.0]
  def change
    change_column_default :inventories, :equipped, from: nil, to: false
  end
end
