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

ActiveRecord::Schema.define(version: 20160321034201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "percent_off", default: 0
    t.integer  "max_uses",    default: 0
    t.integer  "uses",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_notifications", force: :cascade do |t|
    t.integer  "seeker_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_notifications", ["category_id"], name: "index_job_notifications_on_category_id", using: :btree
  add_index "job_notifications", ["seeker_id"], name: "index_job_notifications_on_seeker_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "title",               limit: 255
    t.string   "category",            limit: 255
    t.string   "city",                limit: 255
    t.string   "state",               limit: 255
    t.string   "zip",                 limit: 255
    t.text     "description"
    t.text     "how_to_apply"
    t.text     "company_description"
    t.boolean  "premium"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name",        limit: 255
    t.string   "company_url",         limit: 255
    t.string   "company_email",       limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "full_address",        limit: 255
    t.string   "stripe_customer_id",  limit: 255
    t.string   "stripe_charge_id",    limit: 255
    t.boolean  "published",                       default: false
    t.string   "origin_uid",          limit: 255
    t.integer  "coupon_id"
  end

  create_table "seekers", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255, default: "US"
    t.string   "full_address", limit: 255
    t.string   "string",       limit: 255
    t.integer  "radius"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "seekers", ["email"], name: "index_seekers_on_email", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
