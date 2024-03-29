# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_28_031906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "map_id", null: false
    t.string "country"
    t.string "administrative_area_level_1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "formatted_address", null: false
    t.index ["map_id"], name: "index_addresses_on_map_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "usability_rating"
    t.integer "design_rating"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.index ["user_id", "map_id"], name: "index_likes_on_user_id_and_map_id", unique: true
  end

  create_table "maps", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.bigint "user_id", null: false
    t.string "uid"
    t.index ["user_id"], name: "index_maps_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "uid"
    t.datetime "searched_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "uid"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "youtube_video_id"
    t.string "thumbnail_url"
    t.bigint "map_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_videos_on_map_id"
  end

  add_foreign_key "likes", "maps"
  add_foreign_key "likes", "users"
  add_foreign_key "maps", "users"
  add_foreign_key "searches", "users"
  add_foreign_key "videos", "maps"
end
