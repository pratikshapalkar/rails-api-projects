class CreateAnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :anouncements do |t|
      t.string :description
      t.references :sport, foreign_key: true

      t.timestamps
    end
  end
end
