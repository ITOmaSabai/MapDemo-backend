class AddColumnToMap < ActiveRecord::Migration[7.1]
  def change
    add_column :maps, :lat, :float, null: false
    add_column :maps, :lng, :float, null: false
    
    change_column_null :maps, :name, false
  end
end
