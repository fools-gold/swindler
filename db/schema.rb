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

ActiveRecord::Schema.define(version: 20150603113125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "story_id",   null: false
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["story_id"], name: "index_comments_on_story_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "followships", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "followed_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "followships", ["followed_id"], name: "index_followships_on_followed_id", using: :btree
  add_index "followships", ["follower_id", "followed_id"], name: "index_followships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "followships", ["follower_id"], name: "index_followships_on_follower_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "title",                     null: false
    t.string   "slug"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "stories_count", default: 0, null: false
  end

  add_index "games", ["slug"], name: "index_games_on_slug", unique: true, using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "story_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["story_id", "user_id"], name: "index_likes_on_story_id_and_user_id", unique: true, using: :btree
  add_index "likes", ["story_id"], name: "index_likes_on_story_id", using: :btree
  add_index "likes", ["user_id", "story_id"], name: "index_likes_on_user_id_and_story_id", unique: true, using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.text     "body",                           null: false
    t.integer  "by_id",                          null: false
    t.integer  "of_id",                          null: false
    t.integer  "game_id",                        null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "likes_count",        default: 0, null: false
    t.integer  "comments_count",     default: 0, null: false
  end

  add_index "stories", ["by_id", "of_id", "game_id"], name: "index_stories_on_by_id_and_of_id_and_game_id", using: :btree
  add_index "stories", ["by_id", "of_id"], name: "index_stories_on_by_id_and_of_id", using: :btree
  add_index "stories", ["by_id"], name: "index_stories_on_by_id", using: :btree
  add_index "stories", ["game_id"], name: "index_stories_on_game_id", using: :btree
  add_index "stories", ["of_id"], name: "index_stories_on_of_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                        default: "",    null: false
    t.string   "encrypted_password",           default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                                     null: false
    t.string   "timezone",                                     null: false
    t.boolean  "admin",                        default: false, null: false
    t.string   "slug"
    t.integer  "followings_count",             default: 0,     null: false
    t.integer  "followers_count",              default: 0,     null: false
    t.integer  "stories_count",                default: 0,     null: false
    t.integer  "stories_of_count",             default: 0,     null: false
    t.string   "bio",                          default: "",    null: false
    t.string   "profile_picture_file_name"
    t.string   "profile_picture_content_type"
    t.integer  "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  add_foreign_key "comments", "stories", on_delete: :cascade
  add_foreign_key "comments", "users", on_delete: :cascade
  add_foreign_key "followships", "users", column: "followed_id", on_delete: :cascade
  add_foreign_key "followships", "users", column: "follower_id", on_delete: :cascade
  add_foreign_key "likes", "stories", on_delete: :cascade
  add_foreign_key "likes", "users", on_delete: :cascade
  add_foreign_key "stories", "games", on_delete: :cascade
  add_foreign_key "stories", "users", column: "by_id", on_delete: :cascade
  add_foreign_key "stories", "users", column: "of_id", on_delete: :cascade
end
