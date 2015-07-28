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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20150728125800) do
=======
ActiveRecord::Schema.define(version: 20150728105736) do

  create_table "foodbanks", force: :cascade do |t|
    t.string   "company"
    t.string   "county"
    t.string   "name"
    t.string   "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "latitude"
    t.float    "longitude"
  end
>>>>>>> origin/master

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.string   "food_type"
    t.integer  "time_to_expire_in_days"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "where_stored"
  end

  create_table "foods_recipes", force: :cascade do |t|
    t.integer "food_id"
    t.integer "recipe_id"
  end

  create_table "items", force: :cascade do |t|
    t.decimal  "quantity"
    t.string   "quantity_type"
    t.date     "when_bought"
    t.date     "when_expire"
    t.integer  "user_id"
    t.integer  "food_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "status"
    t.string   "where_stored"
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.string   "instructions"
    t.integer  "user_id"
    t.string   "url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "postcode"
    t.string   "phone"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
