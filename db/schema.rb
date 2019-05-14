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

ActiveRecord::Schema.define(version: 2019_05_13_211650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.integer "chip_id"
    t.string "sex"
    t.string "breed", default: "mix"
    t.string "age"
    t.string "weight"
    t.boolean "is_vaccinated", default: true
    t.boolean "at_risk", default: false
    t.string "intake_date", default: "N/A"
    t.bigint "shelter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "payment_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
