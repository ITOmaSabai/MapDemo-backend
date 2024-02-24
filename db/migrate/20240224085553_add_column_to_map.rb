class AddColumnToMap < ActiveRecord::Migration[7.1]
  def change
    create_table :maps do |t|
      t.float :lat, null: false
      t.float :lng, null: false
    end
    change_column_null :maps, :name, false
  end
end
