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

ActiveRecord::Schema.define(version: 20160418125149) do

  create_table "comments", force: :cascade do |t|
    t.date     "date",                     null: false
    t.integer  "patient_id", limit: 4,     null: false
    t.integer  "user_id",    limit: 4,     null: false
    t.text     "detail",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 50, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "doctor_diagnoses", force: :cascade do |t|
    t.date     "date",                     null: false
    t.integer  "patient_id", limit: 4,     null: false
    t.integer  "user_id",    limit: 4,     null: false
    t.text     "detail",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "patient_histories", force: :cascade do |t|
    t.date     "date",                     null: false
    t.integer  "patient_id", limit: 4,     null: false
    t.integer  "user_id",    limit: 4,     null: false
    t.text     "detail",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "title",         limit: 4,                  null: false
    t.string   "firstName",     limit: 20,                 null: false
    t.string   "lastName",      limit: 20,                 null: false
    t.boolean  "gender",                                   null: false
    t.date     "dob",                                      null: false
    t.string   "bloodGroup",    limit: 3,                  null: false
    t.string   "phone",         limit: 30,    default: ""
    t.string   "email",         limit: 50
    t.text     "streetAddress", limit: 255
    t.string   "city",          limit: 20,    default: ""
    t.string   "country",       limit: 20,    default: ""
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "photo",         limit: 65535
  end

  create_table "queries", force: :cascade do |t|
    t.text     "subject",    limit: 255,   null: false
    t.text     "message",    limit: 65535, null: false
    t.text     "response",   limit: 65535
    t.integer  "user_id",    limit: 4,     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 50,                    null: false
    t.string   "password_digest", limit: 255,                   null: false
    t.string   "firstName",       limit: 20,                    null: false
    t.string   "lastName",        limit: 20,                    null: false
    t.boolean  "gender",                                        null: false
    t.date     "dob",                                           null: false
    t.integer  "userType",        limit: 4,                     null: false
    t.integer  "department_id",   limit: 4,                     null: false
    t.string   "designation",     limit: 30,    default: ""
    t.string   "specialization",  limit: 50,    default: ""
    t.text     "streetAddress",   limit: 255
    t.string   "city",            limit: 20,    default: ""
    t.string   "country",         limit: 20,    default: ""
    t.string   "phone",           limit: 30,    default: ""
    t.text     "about",           limit: 255
    t.text     "status",          limit: 255
    t.text     "photo",           limit: 65535
    t.boolean  "verifyStatus",                  default: false, null: false
    t.string   "verifyToken",     limit: 50
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["verifyToken"], name: "index_users_on_verifyToken", unique: true, using: :btree

end
