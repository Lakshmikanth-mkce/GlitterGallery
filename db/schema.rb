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

ActiveRecord::Schema.define(version: 20160328163217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "json"
    t.string   "text"
    t.string   "blob_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "annotations", ["blob_id"], name: "index_annotations_on_blob_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.string   "polycomment_id"
    t.string   "polycomment_type"
    t.integer  "user_id"
    t.boolean  "issue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["polycomment_type", "polycomment_id"], name: "index_comments_on_polycomment_type_and_polycomment_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keys", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "key"
    t.string   "title"
    t.string   "fingerprint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keys", ["user_id"], name: "index_keys_on_user_id", using: :btree

  create_table "notification_statuses", force: :cascade do |t|
    t.integer  "victim_id"
    t.integer  "notification_id"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "actor_id"
    t.integer  "action"
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url"
  end

  create_table "project_followers", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_members", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "gallery_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_members", ["member_id", "gallery_id"], name: "index_project_members_on_member_id_and_gallery_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "repo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "data_path"
    t.boolean  "private",    default: false
    t.string   "uniqueurl"
    t.string   "urlbase"
    t.string   "ancestry"
    t.datetime "deleted_at"
  end

  add_index "projects", ["ancestry"], name: "index_projects_on_ancestry", using: :btree
  add_index "projects", ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree
  add_index "projects", ["name", "user_id"], name: "index_projects_on_name_and_user_id", unique: true, using: :btree

  create_table "pull_requests", force: :cascade do |t|
    t.string   "desc"
    t.string   "lastcommit"
    t.string   "status"
    t.integer  "parent"
    t.integer  "fork"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pulltable", force: :cascade do |t|
    t.string   "desc"
    t.string   "status"
    t.string   "lastcommit"
    t.integer  "fork"
    t.integer  "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_averages", force: :cascade do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.integer  "rater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_averages", ["rateable_id", "rateable_type"], name: "index_rating_averages_on_rateable_id_and_rateable_type", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  add_index "relationships", ["following_id"], name: "index_relationships_on_following_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "name"
    t.datetime "remember_created_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
