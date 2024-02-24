class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :youtube_video_id
      t.string :thumbnail_url
      t.references :map, null: false, foreign_key: true

      t.timestamps
    end
  end
end
