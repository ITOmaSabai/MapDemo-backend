class AddColumnToAddress < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.bigint :map_id, null: false
      t.string :country
      t.string :administrative_area_level_1
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :formatted_address, null: false

      t.index :map_id
    end
  end
end
