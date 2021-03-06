# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_02_130943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apply_for_events", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "user_id"], name: "index_apply_for_events_on_event_id_and_user_id", unique: true
    t.index ["event_id"], name: "index_apply_for_events_on_event_id"
    t.index ["user_id"], name: "index_apply_for_events_on_user_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "organizer_id"
    t.bigint "paticipant_id"
    t.integer "rate", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organizer_id", "paticipant_id"], name: "index_evaluations_on_organizer_id_and_paticipant_id"
    t.index ["organizer_id"], name: "index_evaluations_on_organizer_id"
    t.index ["paticipant_id"], name: "index_evaluations_on_paticipant_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "content", default: "", null: false
    t.string "restaurant_url", default: "", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "check_in_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "food_category", default: 0, null: false
    t.bigint "user_id"
    t.integer "event_status", default: 0, null: false
    t.bigint "area_id"
    t.datetime "expired_time"
    t.string "restaurant_name", default: "", null: false
    t.string "restaurant_img", default: "", null: false
    t.string "restaurant_access", default: "", null: false
    t.string "budget", default: "", null: false
    t.index ["area_id"], name: "index_events_on_area_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_favorites_on_event_id"
    t.index ["user_id", "event_id"], name: "index_favorites_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "genre_tags", force: :cascade do |t|
    t.bigint "genre_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_genre_tags_on_event_id"
    t.index ["genre_id", "event_id"], name: "index_genre_tags_on_genre_id_and_event_id", unique: true
    t.index ["genre_id"], name: "index_genre_tags_on_genre_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "room_id"
    t.bigint "user_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "icon", default: "", null: false
    t.date "birthday"
    t.integer "gender", default: 0, null: false
    t.string "instagram_url", default: "", null: false
    t.string "facebook_url", default: "", null: false
    t.string "details", default: "", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_rooms_on_recipient_id"
    t.index ["sender_id", "recipient_id"], name: "index_rooms_on_sender_id_and_recipient_id", unique: true
    t.index ["sender_id"], name: "index_rooms_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apply_for_events", "events"
  add_foreign_key "apply_for_events", "users"
  add_foreign_key "evaluations", "users", column: "organizer_id"
  add_foreign_key "evaluations", "users", column: "paticipant_id"
  add_foreign_key "events", "areas"
  add_foreign_key "events", "users"
  add_foreign_key "favorites", "events"
  add_foreign_key "favorites", "users"
  add_foreign_key "genre_tags", "events"
  add_foreign_key "genre_tags", "genres"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "profiles", "users"
end
