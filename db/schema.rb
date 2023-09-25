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

ActiveRecord::Schema.define(version: 2023_09_03_053530) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bodytypes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_items", force: :cascade do |t|
    t.integer "maker_id", null: false
    t.string "name", null: false
    t.integer "num_people", null: false
    t.string "displacement", null: false
    t.string "drive_system", null: false
    t.string "door", null: false
    t.string "mission", null: false
    t.string "model_year", null: false
    t.string "fuel_consumption", null: false
    t.string "weight", null: false
    t.string "size", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bodytype_id", null: false
    t.integer "fuel_id", null: false
    t.float "design_car", default: 3.0, null: false
    t.float "performance_car", default: 3.0, null: false
    t.float "fuel_consumptionrev_car", default: 3.0, null: false
    t.float "quietness_car", default: 3.0, null: false
    t.float "vibration_car", default: 3.0, null: false
    t.float "indoor_space_car", default: 3.0, null: false
    t.float "luggage_space_car", default: 3.0, null: false
    t.float "price_car", default: 3.0, null: false
    t.float "maintenance_cost_car", default: 3.0, null: false
    t.float "safety_car", default: 3.0, null: false
    t.float "assistance_car", default: 3.0, null: false
    t.float "evaluation_car", default: 3.0, null: false
    t.integer "review_count", default: 0, null: false
    t.integer "commuting_tag_count", default: 0, null: false
    t.integer "pick_up_tag_count", default: 0, null: false
    t.integer "shopping_tag_count", default: 0, null: false
    t.integer "sports_tag_count", default: 0, null: false
    t.integer "outdoor_tag_count", default: 0, null: false
    t.integer "offroad_tag_count", default: 0, null: false
    t.integer "long_distance_tag_count", default: 0, null: false
    t.integer "enjoy_tag_count", default: 0, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "review_id", null: false
    t.integer "user_id", null: false
    t.text "comment", null: false
  end

  create_table "fuels", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "makers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "makername", default: "", null: false
  end

  create_table "review_scene_relations", force: :cascade do |t|
    t.integer "review_id", null: false
    t.integer "scene_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_review_scene_relations_on_review_id"
    t.index ["scene_id"], name: "index_review_scene_relations_on_scene_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.text "favorite", null: false
    t.text "complain", null: false
    t.integer "design", default: 3, null: false
    t.integer "performance", default: 3, null: false
    t.integer "fuel_consumptionrev", default: 3, null: false
    t.integer "quietness", default: 3, null: false
    t.integer "vibration", default: 3, null: false
    t.integer "indoor_space", default: 3, null: false
    t.integer "luggage_space", default: 3, null: false
    t.integer "price", default: 3, null: false
    t.integer "maintenance_cost", default: 3, null: false
    t.integer "safety", default: 3, null: false
    t.integer "assistance", default: 3, null: false
    t.float "evaluation", default: 3.0, null: false
    t.string "title_rev"
    t.integer "car_item_id", null: false
    t.integer "status", default: 0, null: false
    t.integer "maker_id"
  end

  create_table "scenes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "review_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_taggings_on_review_id"
    t.index ["tag_id", "review_id"], name: "index_taggings_on_tag_id_and_review_id", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "review_scene_relations", "reviews"
  add_foreign_key "review_scene_relations", "scenes"
  add_foreign_key "taggings", "reviews"
  add_foreign_key "taggings", "tags"
end
