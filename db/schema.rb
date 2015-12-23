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

ActiveRecord::Schema.define(version: 20151107095951) do

  create_table "aggregates", force: :cascade do |t|
    t.integer  "position",   limit: 4
    t.string   "name",       limit: 255
    t.string   "ancestry",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "champion_tips", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.integer  "result",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "champion_tips", ["team_id"], name: "index_champion_tips_on_team_id", using: :btree
  add_index "champion_tips", ["user_id"], name: "index_champion_tips_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.boolean  "edited"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "position",           limit: 4
    t.integer  "aggregate_id",       limit: 4
    t.integer  "team_1_id",          limit: 4
    t.integer  "team_2_id",          limit: 4
    t.integer  "score_team_1",       limit: 4
    t.integer  "score_team_2",       limit: 4
    t.string   "placeholder_team_1", limit: 255
    t.string   "placeholder_team_2", limit: 255
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["aggregate_id"], name: "index_matches_on_aggregate_id", using: :btree
  add_index "matches", ["team_1_id"], name: "index_matches_on_team_1_id", using: :btree
  add_index "matches", ["team_2_id"], name: "index_matches_on_team_2_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranking_items", force: :cascade do |t|
    t.integer  "match_id",                         limit: 4
    t.integer  "user_id",                          limit: 4
    t.integer  "position",                         limit: 4
    t.boolean  "correct_champion_tip"
    t.integer  "correct_tips_count",               limit: 4
    t.integer  "correct_tendency_tips_only_count", limit: 4
    t.integer  "points",                           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranking_items", ["match_id"], name: "index_ranking_items_on_match_id", using: :btree
  add_index "ranking_items", ["user_id"], name: "index_ranking_items_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "country",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "match_id",     limit: 4
    t.integer  "score_team_1", limit: 4
    t.integer  "score_team_2", limit: 4
    t.integer  "result",       limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tips", ["match_id"], name: "index_tips_on_match_id", using: :btree
  add_index "tips", ["user_id"], name: "index_tips_on_user_id", using: :btree

  create_table "user_badges", force: :cascade do |t|
    t.integer  "user_id",                limit: 4
    t.string   "badge_identifier",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "badge_group_identifier", limit: 255
  end

  add_index "user_badges", ["user_id"], name: "index_user_badges_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "nickname",               limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "admin"
    t.boolean  "active",                             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "match_sort",             limit: 255
    t.boolean  "titleholder"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
