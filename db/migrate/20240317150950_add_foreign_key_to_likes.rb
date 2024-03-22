class AddForeignKeyToLikes < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :likes, :users
    add_foreign_key :likes, :maps
  end
end
