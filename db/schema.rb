# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160325175503) do

  create_table "areas", force: :cascade do |t|
    t.integer  "map_id"
    t.string   "ref"
    t.string   "title"
    t.string   "spotted_map"
    t.float    "square"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "areas", ["map_id"], name: "index_areas_on_map_id"

  create_table "contracts", force: :cascade do |t|
    t.string   "title"
    t.integer  "renter_id"
    t.integer  "area_id"
    t.float    "rate"
    t.date     "date_start"
    t.date     "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contracts", ["area_id"], name: "index_contracts_on_area_id"
  add_index "contracts", ["renter_id"], name: "index_contracts_on_renter_id"

  create_table "maps", force: :cascade do |t|
    t.string   "title"
    t.string   "map"
    t.string   "dashboard_map"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "renters", force: :cascade do |t|
    t.string   "title"
    t.float    "account",    default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "contract_string"
    t.string   "renter_string"
    t.string   "area_string"
    t.integer  "contract_id"
    t.integer  "renter_id"
    t.integer  "area_id"
    t.float    "amount"
    t.float    "account_were"
    t.float    "account"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "comment"
  end

  add_index "transactions", ["area_id"], name: "index_transactions_on_area_id"
  add_index "transactions", ["contract_id"], name: "index_transactions_on_contract_id"
  add_index "transactions", ["renter_id"], name: "index_transactions_on_renter_id"

end
