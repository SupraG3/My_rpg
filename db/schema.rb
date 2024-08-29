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

ActiveRecord::Schema[7.1].define(version: 2024_06_15_135146) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "battles", force: :cascade do |t|
    t.integer "player_id"
    t.integer "quest_id"
    t.integer "player_health"
    t.integer "opponent_health"
    t.integer "current_turn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "item_id", null: false
    t.boolean "equipped", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_inventories_on_item_id"
    t.index ["player_id"], name: "index_inventories_on_player_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "health_bonus"
    t.integer "strength_bonus"
    t.integer "experience_bonus"
    t.string "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "npcs", force: :cascade do |t|
    t.string "name"
    t.integer "health"
    t.integer "strength"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.integer "experience"
    t.integer "health"
    t.integer "strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "points"
    t.integer "level_up_points"
    t.integer "manual_health_points"
    t.integer "manual_strength_points"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "quests", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "steps", force: :cascade do |t|
    t.integer "quest_id", null: false
    t.text "description"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question"
    t.string "correct_answer"
    t.string "wrong_answer"
    t.integer "reward_item_id"
    t.index ["quest_id"], name: "index_steps_on_quest_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "inventories", "items"
  add_foreign_key "inventories", "players"
  add_foreign_key "players", "users"
  add_foreign_key "steps", "quests"
end
