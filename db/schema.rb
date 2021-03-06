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

ActiveRecord::Schema.define(version: 2019_05_26_212519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "chip_id"
    t.string "sex"
    t.string "breed", default: "mix"
    t.string "age"
    t.boolean "is_vaccinated", default: true
    t.boolean "at_risk", default: false
    t.bigint "shelter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["shelter_id"], name: "index_dogs_on_shelter_id"
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount"
    t.string "note"
    t.bigint "user_id"
    t.bigint "dog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_payments_on_dog_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

end
