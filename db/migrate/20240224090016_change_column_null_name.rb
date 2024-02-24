class ChangeColumnNullName < ActiveRecord::Migration[7.1]
  def change
    change_column_null :maps, :name, false
  end
end
