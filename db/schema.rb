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

ActiveRecord::Schema.define(version: 20180122075014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string   "name",       default: "Need to rename that :("
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "number",       default: "Need to rename that :("
    t.integer  "specialty_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "passes", force: :cascade do |t|
    t.date     "date_of_pass",                           null: false
    t.string   "lesson",       default: "Не указано :("
    t.integer  "hours",        default: 2,               null: false
    t.string   "cause",        default: "Не указано :("
    t.integer  "student_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "name",          default: "Need to rename that :("
    t.integer  "department_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "name",       default: "-"
    t.string   "surname",    default: "-"
    t.string   "fathername", default: "-"
    t.string   "birthday",   default: "-"
    t.string   "adress",     default: "-"
    t.integer  "group_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "persistence_token"
    t.integer  "admin",             default: 0, null: false
    t.integer  "superadmin",        default: 0, null: false
    t.string   "name"
    t.string   "surname"
    t.string   "position"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
