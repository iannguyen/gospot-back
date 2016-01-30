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

ActiveRecord::Schema.define(version: 20160129013038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "team_id",    null: false
    t.integer  "match_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bets", ["team_id"], name: "index_bets_on_team_id", using: :btree
  add_index "bets", ["user_id", "match_id"], name: "index_bets_on_user_id_and_match_id", using: :btree
  add_index "bets", ["user_id"], name: "index_bets_on_user_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.string   "location",                     null: false
    t.integer  "team_1_id",                    null: false
    t.integer  "team_2_id",                    null: false
    t.integer  "team_1_score", default: 0,     null: false
    t.integer  "team_2_score", default: 0,     null: false
    t.integer  "team_1_odds",  default: 0,     null: false
    t.integer  "team_2_odds",  default: 0,     null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "open",         default: false
    t.integer  "start_hour",                   null: false
  end

  add_index "matches", ["team_1_id"], name: "index_matches_on_team_1_id", using: :btree
  add_index "matches", ["team_2_id"], name: "index_matches_on_team_2_id", using: :btree

  create_table "payouts", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "payouts", ["user_id"], name: "index_payouts_on_user_id", using: :btree

  create_table "skins", force: :cascade do |t|
    t.string   "name",       null: false
    t.float    "price",      null: false
    t.integer  "user_id",    null: false
    t.integer  "bet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "payout_id"
  end

  add_index "skins", ["bet_id"], name: "index_skins_on_bet_id", using: :btree
  add_index "skins", ["payout_id"], name: "index_skins_on_payout_id", using: :btree
  add_index "skins", ["user_id"], name: "index_skins_on_user_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "authentication_token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
