class AddUidColumnToLike < ActiveRecord::Migration[7.1]
  def change
    add_column :likes, :uid, :string
  end
end
