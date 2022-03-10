class CreateDataDecryptions < ActiveRecord::Migration[5.2]
  def change
    create_table :data_decryptions do |t|

      t.timestamps
    end
  end
end
