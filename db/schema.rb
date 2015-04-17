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

ActiveRecord::Schema.define(version: 20150413231522) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "randomizers", force: :cascade do |t|
    t.string   "player_checksum", limit: 255
    t.string   "player_1",        limit: 255,                null: false
    t.string   "p1_hash",         limit: 255
    t.string   "player_2",        limit: 255,                null: false
    t.string   "p2_hash",         limit: 255
    t.string   "player_3",        limit: 255
    t.string   "p3_hash",         limit: 255
    t.string   "player_4",        limit: 255
    t.string   "p4_hash",         limit: 255
    t.string   "player_5",        limit: 255
    t.string   "p5_hash",         limit: 255
    t.string   "player_6",        limit: 255
    t.string   "p6_hash",         limit: 255
    t.string   "player_7",        limit: 255
    t.string   "p7_hash",         limit: 255
    t.string   "player_8",        limit: 255
    t.string   "p8_hash",         limit: 255
    t.boolean  "arborec",         limit: 1,   default: true
    t.string   "r1_hash",         limit: 255
    t.boolean  "barony",          limit: 1,   default: true
    t.string   "r2_hash",         limit: 255
    t.boolean  "yin",             limit: 1,   default: true
    t.string   "r3_hash",         limit: 255
    t.boolean  "saar",            limit: 1,   default: true
    t.string   "r4_hash",         limit: 255
    t.boolean  "muaat",           limit: 1,   default: true
    t.string   "r5_hash",         limit: 255
    t.boolean  "hacan",           limit: 1,   default: true
    t.string   "r6_hash",         limit: 255
    t.boolean  "sol",             limit: 1,   default: true
    t.string   "r7_hash",         limit: 255
    t.boolean  "creuss",          limit: 1,   default: true
    t.string   "r8_hash",         limit: 255
    t.boolean  "l1z1x",           limit: 1,   default: true
    t.string   "r9_hash",         limit: 255
    t.boolean  "mentak",          limit: 1,   default: true
    t.string   "r10_hash",        limit: 255
    t.boolean  "naalu",           limit: 1,   default: true
    t.string   "r11_hash",        limit: 255
    t.boolean  "nekro",           limit: 1,   default: true
    t.string   "r12_hash",        limit: 255
    t.boolean  "sardakk",         limit: 1,   default: true
    t.string   "r13_hash",        limit: 255
    t.boolean  "jolnar",          limit: 1,   default: true
    t.string   "r14_hash",        limit: 255
    t.boolean  "winnu",           limit: 1,   default: true
    t.string   "r15_hash",        limit: 255
    t.boolean  "xxcha",           limit: 1,   default: true
    t.string   "r16_hash",        limit: 255
    t.boolean  "yssaril",         limit: 1,   default: true
    t.string   "r17_hash",        limit: 255
    t.boolean  "lazax",           limit: 1,   default: true
    t.string   "r18_hash",        limit: 255
    t.boolean  "lazax_sub",       limit: 1,   default: true
    t.datetime "clock"
    t.string   "last_block_hash", limit: 11
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "race_checksum",   limit: 255
  end

end
