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

ActiveRecord::Schema[7.1].define(version: 2025_10_31_071707) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "definitions", force: :cascade do |t|
    t.bigint "part_of_speech_id", null: false
    t.text "definition"
    t.text "example"
    t.json "synonyms"
    t.json "antonyms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_of_speech_id"], name: "index_definitions_on_part_of_speech_id"
  end

  create_table "meanings", force: :cascade do |t|
    t.bigint "word_id", null: false
    t.text "definition"
    t.string "part_of_speech"
    t.text "example"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_meanings_on_word_id"
  end

  create_table "part_of_speeches", force: :cascade do |t|
    t.string "part_of_speech"
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_part_of_speeches_on_word_id"
  end

  create_table "user_words", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "word_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.integer "status"
    t.index ["user_id"], name: "index_user_words_on_user_id"
    t.index ["word_id"], name: "index_user_words_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "spelling"
    t.string "pronunciation"
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "definitions", "part_of_speeches"
  add_foreign_key "meanings", "words"
  add_foreign_key "part_of_speeches", "words"
  add_foreign_key "user_words", "users"
  add_foreign_key "user_words", "words"
end
