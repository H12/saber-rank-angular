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

ActiveRecord::Schema.define(version: 20151201164735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batters", force: :cascade do |t|
    t.string   "name"
    t.string   "team"
    t.string   "avg"
    t.integer  "hr"
    t.integer  "r"
    t.integer  "rbi"
    t.integer  "sb"
    t.string   "slg"
    t.string   "obp"
    t.string   "ops"
    t.integer  "so"
    t.integer  "singles"
    t.integer  "doubles"
    t.integer  "triples"
    t.integer  "ab"
    t.integer  "bb"
    t.integer  "cs"
    t.integer  "gdp"
    t.integer  "h"
    t.integer  "hbp"
    t.integer  "ibb"
    t.integer  "pitches"
    t.integer  "pa"
    t.integer  "sf"
    t.integer  "sh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
