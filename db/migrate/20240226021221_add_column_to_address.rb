class AddColumnToAddress < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :formatted_address, :string, null: false
  end
end
