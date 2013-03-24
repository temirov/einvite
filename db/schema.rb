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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130323182256) do

  create_table "authorizations", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "session_token"
    t.string   "plain_password"
  end

  add_index "authorizations", ["session_token"], :name => "index_authorizations_on_last_token"
  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "competitions", ["user_id"], :name => "index_competitions_on_user_id"

  create_table "competitions_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "competition_id"
  end

  add_index "competitions_users", ["competition_id"], :name => "index_competitions_users_on_competition_id"
  add_index "competitions_users", ["user_id"], :name => "index_competitions_users_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "authorization_id"
    t.integer  "competition_id"
  end

  add_index "users", ["authorization_id"], :name => "index_users_on_authorization_id"
  add_index "users", ["competition_id"], :name => "index_users_on_competition_id"
  add_index "users", ["email"], :name => "index_users_on_email"

end
