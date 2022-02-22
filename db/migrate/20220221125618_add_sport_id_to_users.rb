class AddSportIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sport_id, :integer
    add_index :users, :sport_id
  end
end
