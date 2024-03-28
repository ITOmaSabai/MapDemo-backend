class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :uid
      t.datetime :searched_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
