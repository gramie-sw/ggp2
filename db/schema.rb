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

ActiveRecord::Schema.define(version: 20160718194819) do

  create_table "aggregates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "champion_tips", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["team_id"], name: "index_champion_tips_on_team_id", using: :btree
    t.index ["user_id"], name: "index_champion_tips_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id"
    t.text     "content",    limit: 65535
    t.boolean  "edited"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "position"
    t.integer  "aggregate_id"
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.integer  "score_team_1"
    t.integer  "score_team_2"
    t.string   "placeholder_team_1"
    t.string   "placeholder_team_2"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["aggregate_id"], name: "index_matches_on_aggregate_id", using: :btree
    t.index ["team_1_id"], name: "index_matches_on_team_1_id", using: :btree
    t.index ["team_2_id"], name: "index_matches_on_team_2_id", using: :btree
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranking_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.integer  "position"
    t.boolean  "correct_champion_tip"
    t.integer  "correct_tips_count"
    t.integer  "correct_tendency_tips_count"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["match_id"], name: "index_ranking_items_on_match_id", using: :btree
    t.index ["user_id"], name: "index_ranking_items_on_user_id", using: :btree
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "team_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "score_team_1"
    t.integer  "score_team_2"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["match_id"], name: "index_tips_on_match_id", using: :btree
    t.index ["user_id"], name: "index_tips_on_user_id", using: :btree
  end

  create_table "user_badges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "user_id"
    t.string   "badge_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "badge_group_identifier"
    t.index ["user_id"], name: "index_user_badges_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
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
    t.string   "most_valuable_badge"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
