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

ActiveRecord::Schema.define(version: 20161228234625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "intersections", force: :cascade do |t|
    t.string   "streets"
    t.string   "city"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "street_one"
    t.string   "street_two"
    t.string   "formatted_address"
    t.integer  "state_id"
    t.index ["state_id"], name: "index_intersections_on_state_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "body"
    t.integer  "rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.integer  "intersection_id"
    t.index ["intersection_id"], name: "index_reviews_on_intersection_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "postal_code"
    t.text     "cities",      default: [],              array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "intersections", "states"
end
