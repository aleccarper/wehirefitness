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

ActiveRecord::Schema.define(version: 20150821041941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.string   "category"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "description"
    t.string   "how_to_apply"
    t.string   "company_description"
    t.boolean  "premium"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
    t.string   "company_url"
    t.string   "company_email"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "full_address"
    t.string   "stripe_customer_id"
    t.string   "stripe_charge_id"
  end

end
