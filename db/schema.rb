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

ActiveRecord::Schema.define(version: 2019_12_13_065132) do

  create_table "profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "address"
    t.string "vehicle_type"
    t.text "resident_state"
    t.string "vehicle_number"
    t.text "preferred_distance"
    t.text "routes"
    t.string "drivers_license"
    t.datetime "driver_license_expiry_date"
    t.text "profile_picture"
    t.string "account_name"
    t.string "account_number"
    t.string "bank_name"
    t.string "account_type"
    t.bigint "user_id", null: false
    t.string "referral_name"
    t.boolean "is_active", default: true
    t.boolean "is_available", default: false
    t.boolean "is_verified", default: true
    t.boolean "is_busy"
    t.boolean "is_confirmed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "trip_requests", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vehicle_type_id"
    t.float "fee"
    t.string "destination_address"
    t.string "pickup_address"
    t.datetime "eta"
    t.datetime "pickup_date"
    t.string "contact_email"
    t.string "contact_number"
    t.float "weight"
    t.text "description"
    t.integer "quantity"
    t.integer "vechicles_qty"
    t.integer "driver_id"
    t.integer "created_by"
    t.integer "status"
    t.float "driver_fee"
    t.float "commission"
    t.float "distance"
    t.boolean "is_approved_admin"
    t.boolean "is_approved_user"
    t.boolean "is_paid"
    t.boolean "driver_paid"
    t.float "trip_amount"
    t.text "contact_address"
    t.string "pickup_time"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trip_requests_on_user_id"
    t.index ["vehicle_type_id"], name: "index_trip_requests_on_vehicle_type_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "password_digest"
    t.string "phone_number"
    t.string "role"
    t.boolean "admin", default: false
    t.integer "user_type"
    t.text "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicle_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "vehicle_id", null: false
    t.string "image"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vehicle_id"], name: "index_vehicle_images_on_vehicle_id"
  end

  create_table "vehicle_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "icon"
    t.float "max_price_per_km"
    t.float "min_price_per_km"
    t.float "commission_rate"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vehicles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vehicle_type_id", null: false
    t.string "plate_number"
    t.string "serial_no"
    t.string "chassis_no"
    t.string "license"
    t.string "license_no"
    t.string "license_expiry_date"
    t.string "license_issue_date"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_type_id"], name: "index_vehicles_on_vehicle_type_id"
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "vehicle_images", "vehicles"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_types"
end
