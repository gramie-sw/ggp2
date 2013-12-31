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

ActiveRecord::Schema.define(version: 20131231164718) do

  create_table "aggregates", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "position"
    t.integer  "aggregate_id"
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "score_team_1"
    t.integer  "score_team_2"
    t.string   "placeholder_team_1"
    t.string   "placeholder_team_2"
    t.integer  "venue_id"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["aggregate_id"], name: "index_matches_on_aggregate_id", using: :btree
  add_index "matches", ["team_1_id"], name: "index_matches_on_team_1_id", using: :btree
  add_index "matches", ["team_2_id"], name: "index_matches_on_team_2_id", using: :btree
  add_index "matches", ["venue_id"], name: "index_matches_on_venue_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.string   "city"
    t.string   "stadium"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
