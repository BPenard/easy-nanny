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

ActiveRecord::Schema[7.1].define(version: 2024_06_03_133042) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "child_contracts", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_child_contracts_on_child_id"
    t.index ["contract_id"], name: "index_child_contracts_on_contract_id"
  end

  create_table "children", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "contract_type"
    t.integer "weekly_worked_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.text "description"
    t.date "date"
    t.string "type"
    t.bigint "contract_id", null: false
    t.bigint "user_id", null: false
    t.bigint "child_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_events_on_child_id"
    t.index ["contract_id"], name: "index_events_on_contract_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "payslips", force: :cascade do |t|
    t.date "month_of_payslip"
    t.float "paid_amount"
    t.date "payment_date"
    t.float "employer_contributions"
    t.float "employee_contributions"
    t.float "gross_salary"
    t.float "tax_rate"
    t.bigint "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_payslips_on_contract_id"
  end

  create_table "user_contracts", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_user_contracts_on_contract_id"
    t.index ["user_id"], name: "index_user_contracts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "role"
    t.string "address"
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "child_contracts", "children"
  add_foreign_key "child_contracts", "contracts"
  add_foreign_key "events", "children"
  add_foreign_key "events", "contracts"
  add_foreign_key "events", "users"
  add_foreign_key "payslips", "contracts"
  add_foreign_key "user_contracts", "contracts"
  add_foreign_key "user_contracts", "users"
end
