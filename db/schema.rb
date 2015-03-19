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

ActiveRecord::Schema.define(version: 20150319162351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id",        null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.text     "body",             null: false
    t.string   "title",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "ticker",     null: false
    t.string   "name",       null: false
    t.decimal  "price",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["ticker", "name"], name: "index_companies_on_ticker_and_name", unique: true, using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",   null: false
    t.string   "followable_type", null: false
    t.integer  "follower_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "follower_id"], name: "index_follows_on_followable_id_and_follower_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "notifiable_id",   null: false
    t.string   "notifiable_type", null: false
    t.integer  "event_id",        null: false
    t.boolean  "is_read",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "rateable_id",   null: false
    t.string   "rateable_type", null: false
    t.integer  "rater_id",      null: false
    t.integer  "rating",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["rateable_id", "rater_id"], name: "index_ratings_on_rateable_id_and_rater_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                null: false
    t.string   "first_name",           null: false
    t.string   "last_name",            null: false
    t.string   "password_digest",      null: false
    t.string   "job_title"
    t.text     "description"
    t.string   "session_token",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "notifications_count"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email", "session_token"], name: "index_users_on_email_and_session_token", unique: true, using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree

end
