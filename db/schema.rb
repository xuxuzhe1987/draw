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

ActiveRecord::Schema[7.0].define(version: 2023_08_26_115407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.string "result"
    t.bigint "user_id", null: false
    t.bigint "round_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_participants_on_round_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "num"
    t.string "target"
    t.string "keyword"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "arrayraw", default: [], array: true
    t.integer "arraynew", default: [], array: true
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "open_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "participants", "rounds"
  add_foreign_key "participants", "users"
  add_foreign_key "rounds", "users"
end
