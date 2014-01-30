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

ActiveRecord::Schema.define(version: 20140130030606) do

  create_table "games", force: true do |t|
    t.string   "status"
    t.integer  "winner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "st_activity_id"
    t.integer  "st_points_change"
    t.string   "st_redemption_ids"
  end

  add_index "games", ["winner"], name: "games_winner_fk", using: :btree

  create_table "games_players", force: true do |t|
    t.integer "game_id"
    t.integer "player_id"
  end

  add_index "games_players", ["game_id"], name: "games_players_game_id_fk", using: :btree
  add_index "games_players", ["player_id"], name: "games_players_player_id_fk", using: :btree

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "st_id"
    t.integer  "st_points_balance"
  end

  add_foreign_key "games", "players", name: "games_winner_fk", column: "winner", dependent: :delete

  add_foreign_key "games_players", "games", name: "games_players_game_id_fk", dependent: :delete
  add_foreign_key "games_players", "players", name: "games_players_player_id_fk", dependent: :delete

end
