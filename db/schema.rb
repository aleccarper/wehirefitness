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

ActiveRecord::Schema.define(version: 20160229044637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_notifications", force: true do |t|
    t.integer  "seeker_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_notifications", ["category_id"], name: "index_job_notifications_on_category_id", using: :btree
  add_index "job_notifications", ["seeker_id"], name: "index_job_notifications_on_seeker_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.string   "category"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "description"
    t.text     "how_to_apply"
    t.text     "company_description"
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
    t.boolean  "published",           default: false
    t.string   "origin_uid"
  end

  create_table "seekers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "city"
    t.string   "state"
    t.string   "country",      default: "US"
    t.string   "full_address"
    t.string   "string"
    t.integer  "radius"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "seekers", ["email"], name: "index_seekers_on_email", unique: true, using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
