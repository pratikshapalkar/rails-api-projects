class AddProductIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :product_id, :integer
    add_index :users, :product_id
  end
end
