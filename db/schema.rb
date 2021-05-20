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

ActiveRecord::Schema.define(version: 2021_05_14_182639) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "last_used_at"
    t.boolean "status", default: true
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["last_used_at"], name: "index_sessions_on_last_used_at"
    t.index ["status"], name: "index_sessions_on_status"
    t.index ["token"], name: "index_sessions_on_token", unique: true
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "user_verifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status", default: "pending"
    t.string "token"
    t.string "verify_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["status"], name: "index_user_verifications_on_status"
    t.index ["token"], name: "index_user_verifications_on_token", unique: true
    t.index ["user_id"], name: "index_user_verifications_on_user_id"
    t.index ["verify_type"], name: "index_user_verifications_on_verify_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "email_confirmed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email_confirmed_at"], name: "index_users_on_email_confirmed_at"
  end

  add_foreign_key "sessions", "users"
  add_foreign_key "user_verifications", "users"
end
