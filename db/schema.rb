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

ActiveRecord::Schema.define(version: 20140611155146) do

  create_table "aggregates", force: true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "champion_tips", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "champion_tips", ["team_id"], name: "index_champion_tips_on_team_id", using: :btree
  add_index "champion_tips", ["user_id"], name: "index_champion_tips_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.boolean  "edited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "censored"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

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

  create_table "properties", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranking_items", force: true do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.integer  "position"
    t.boolean  "correct_champion_tip"
    t.integer  "correct_tips_count"
    t.integer  "correct_tendency_tips_only_count"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranking_items", ["match_id"], name: "index_ranking_items_on_match_id", using: :btree
  add_index "ranking_items", ["user_id"], name: "index_ranking_items_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "score_team_1"
    t.integer  "score_team_2"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tips", ["match_id"], name: "index_tips_on_match_id", using: :btree
  add_index "tips", ["user_id"], name: "index_tips_on_user_id", using: :btree

  create_table "user_badges", force: true do |t|
    t.integer  "user_id"
    t.string   "badge_identifier"
    t.integer  "position"
    t.string   "icon"
    t.string   "icon_color"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_badges", ["user_id"], name: "index_user_badges_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.boolean  "active",                 default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "match_sort"
    t.boolean  "titleholder"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "city"
    t.string   "stadium"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
