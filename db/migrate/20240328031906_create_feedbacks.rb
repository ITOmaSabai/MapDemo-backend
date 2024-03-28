class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.integer :usability_rating
      t.integer :design_rating
      t.string :body

      t.timestamps
    end
  end
end
