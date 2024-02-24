class AddLatLngColumnToMap < ActiveRecord::Migration[7.1]
  def change
    add_column :maps, :lat, :float, null: false
    add_column :maps, :lng, :float, null: false
  end
end
