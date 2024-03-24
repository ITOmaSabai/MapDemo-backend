class AddUidColumnToMap < ActiveRecord::Migration[7.1]
  def change
    add_column :maps, :uid, :string
  end
end
