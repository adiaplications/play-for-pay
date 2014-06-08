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

ActiveRecord::Schema.define(version: 20140606135631) do

  create_table "admin_users", force: true do |t|
    t.string   "username",        limit: 25, null: false
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", force: true do |t|
    t.integer  "campaign_id"
    t.string   "country",                             default: "", null: false
    t.decimal  "price",       precision: 4, scale: 2,              null: false
    t.string   "link_url",                            default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ads", ["campaign_id"], name: "index_ads_on_campaign_id", using: :btree
  add_index "ads", ["country"], name: "index_ads_on_country", using: :btree

  create_table "campaigns", force: true do |t|
    t.string   "company",        limit: 30,                         default: "Mobpartner", null: false
    t.string   "os",                                                default: "Android",    null: false
    t.string   "commision_type",                                    default: "CPI",        null: false
    t.string   "name",           limit: 30,                         default: "",           null: false
    t.string   "image_url",                                         default: "",           null: false
    t.string   "package_name",                                      default: "",           null: false
    t.string   "package_type",                                      default: "Game",       null: false
    t.boolean  "active",                                            default: true
    t.decimal  "min_sdk",                   precision: 3, scale: 2
    t.boolean  "notifications",                                     default: false
    t.boolean  "emailing",                                          default: false
    t.boolean  "sms",                                               default: false
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["company"], name: "index_campaigns_on_company", using: :btree
  add_index "campaigns", ["name"], name: "index_campaigns_on_name", using: :btree

  create_table "pages", force: true do |t|
    t.integer  "subject_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "visible",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree
  add_index "pages", ["subject_id"], name: "index_pages_on_subject_id", using: :btree

  create_table "sections", force: true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",      default: false
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["page_id"], name: "index_sections_on_page_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name", limit: 25
    t.string   "last_name",  limit: 50
    t.string   "email",                 default: "", null: false
    t.string   "password",   limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
