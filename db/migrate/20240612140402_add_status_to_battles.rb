class AddStatusToBattles < ActiveRecord::Migration[7.1]
  def change
    add_column :battles, :status, :string
  end
end
