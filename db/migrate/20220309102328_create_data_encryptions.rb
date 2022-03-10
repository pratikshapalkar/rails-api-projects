class CreateDataEncryptions < ActiveRecord::Migration[5.2]
  def change
    create_table :data_encryptions do |t|

      t.timestamps
    end
  end
end
