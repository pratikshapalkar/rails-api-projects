class AddColumnsToAchievements < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :status, :string
  end
end
