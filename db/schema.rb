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

ActiveRecord::Schema[7.1].define(version: 2024_09_23_133107) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organisations", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "address"
    t.string "country"
    t.string "province"
    t.string "zip"
    t.string "vat_id", null: false
    t.string "email", null: false
    t.string "segment"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_organisations_on_uuid", unique: true
    t.index ["vat_id"], name: "index_organisations_on_vat_id", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_payments_on_receiver_id"
    t.index ["sender_id"], name: "index_payments_on_sender_id"
    t.index ["vendor_id"], name: "index_payments_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name", null: false
    t.string "uuid", null: false
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_vendors_on_uuid", unique: true
  end

  add_foreign_key "payments", "organisations", column: "receiver_id"
  add_foreign_key "payments", "organisations", column: "sender_id"
  add_foreign_key "payments", "vendors"
end
