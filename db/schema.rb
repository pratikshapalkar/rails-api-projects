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

ActiveRecord::Schema.define(version: 2022_02_21_172331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "award"
    t.string "medals"
    t.bigint "sport_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["sport_id"], name: "index_achievements_on_sport_id"
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "anouncements", force: :cascade do |t|
    t.string "description"
    t.bigint "sport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_anouncements_on_sport_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.bigint "sport_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["sport_id"], name: "index_posts_on_sport_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.integer "no_of_player"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.integer "role", default: 0
    t.string "gender"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "sport_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["sport_id"], name: "index_users_on_sport_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "achievements", "sports"
  add_foreign_key "achievements", "users"
  add_foreign_key "anouncements", "sports"
  add_foreign_key "posts", "sports"
  add_foreign_key "posts", "users"
end
