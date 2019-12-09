# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_09_141638) do

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "address"
    t.string "vehicle_type"
    t.text "resident_state"
    t.string "vehicle_number"
    t.text "preferred_distance"
    t.text "routes"
    t.string "drivers_license"
    t.datetime "driver_license_expiry_date"
    t.string "vehicle_license_number"
    t.datetime "vehicle_license_number_expiry"
    t.text "profile_picture"
    t.string "account_name"
    t.string "account_number"
    t.string "bank_name"
    t.string "account_type"
    t.bigint "user_id", null: false
    t.string "referral_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "password_digest"
    t.string "phone_number"
    t.string "role"
    t.boolean "admin", default: false
    t.text "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "profiles", "users"
end
