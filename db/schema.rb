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

ActiveRecord::Schema.define(version: 20140327150536) do

  create_table "blog_posts", force: true do |t|
    t.text     "body"
    t.integer  "user"
    t.string   "title"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "blog_posts", ["user_id"], name: "index_blog_posts_on_user_id"

  create_table "day_items", force: true do |t|
    t.date     "day"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "day_items", ["user_id"], name: "index_day_items_on_user_id"

  create_table "exercise_comments", force: true do |t|
    t.string   "commenter_email"
    t.text     "body"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "commenter_name"
  end

  add_index "exercise_comments", ["exercise_id"], name: "index_exercise_comments_on_exercise_id"

  create_table "exercises", force: true do |t|
    t.decimal  "distance"
    t.integer  "duration"
    t.integer  "user_id"
    t.text     "comment"
    t.string   "activity"
    t.date     "activity_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit",          default: "Miles"
    t.string   "title"
    t.integer  "day_item_id"
  end

  add_index "exercises", ["day_item_id"], name: "index_exercises_on_day_item_id"
  add_index "exercises", ["user_id", "created_at"], name: "index_exercises_on_user_id_and_created_at"

  create_table "notifications", force: true do |t|
    t.integer  "team_id"
    t.string   "what"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["team_id"], name: "index_notifications_on_team_id"
  add_index "notifications", ["user_id", "team_id"], name: "index_notifications_on_user_id_and_team_id", unique: true
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "team_goals", force: true do |t|
    t.integer  "team_id"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "distance"
    t.integer  "duration"
    t.string   "activity"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_goals", ["team_id"], name: "index_team_goals_on_team_id"

  create_table "team_user_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "team_user_relationships", ["team_id"], name: "index_team_user_relationships_on_team_id"
  add_index "team_user_relationships", ["user_id", "team_id"], name: "index_team_user_relationships_on_user_id_and_team_id", unique: true
  add_index "team_user_relationships", ["user_id"], name: "index_team_user_relationships_on_user_id"

  create_table "teams", force: true do |t|
    t.text     "captains"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",            default: false
    t.integer  "duration"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "provider"
    t.string   "image_link"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
