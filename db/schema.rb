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

ActiveRecord::Schema.define(:version => 20130216193752) do

  create_table "calenders", :force => true do |t|
    t.datetime "begin_of_event"
    t.datetime "end_of_event"
    t.string   "place"
    t.string   "title"
    t.string   "comment"
    t.string   "link"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "group_id"
    t.integer  "user_id"
  end

  add_index "calenders", ["group_id"], :name => "index_calenders_on_group_id"
  add_index "calenders", ["id"], :name => "index_calenders_on_id"
  add_index "calenders", ["user_id"], :name => "index_calenders_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "tour_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["id"], :name => "index_comments_on_id"
  add_index "comments", ["tour_id"], :name => "index_comments_on_tour_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["id"], :name => "index_groups_on_id"

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.boolean "admin",    :default => false
  end

  add_index "groups_users", ["group_id"], :name => "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "news", :force => true do |t|
    t.integer  "user_id"
    t.string   "link"
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "news", ["id"], :name => "index_news_on_id"
  add_index "news", ["user_id"], :name => "index_news_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.string   "text"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["id"], :name => "index_posts_on_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "ratings", :force => true do |t|
    t.integer  "tour_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "route"
    t.integer  "speed"
  end

  add_index "ratings", ["id"], :name => "index_ratings_on_id"
  add_index "ratings", ["tour_id"], :name => "index_ratings_on_tour_id"
  add_index "ratings", ["user_id"], :name => "index_ratings_on_user_id"

  create_table "tour_attendees", :force => true do |t|
    t.integer  "tour_id"
    t.integer  "user_id"
    t.boolean  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tour_attendees", ["tour_id"], :name => "index_tour_attendees_on_tour_id"
  add_index "tour_attendees", ["user_id"], :name => "index_tour_attendees_on_user_id"

  create_table "tours", :force => true do |t|
    t.integer  "user_id"
    t.integer  "duration"
    t.datetime "start_at"
    t.string   "route"
    t.string   "meeting_point"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "link"
    t.string   "tour_type"
    t.integer  "rated"
    t.integer  "distance"
    t.string   "comment"
    t.integer  "rating"
    t.integer  "alt"
    t.integer  "group_id"
    t.string   "track_file_name"
    t.string   "track_content_type"
    t.integer  "track_file_size"
    t.datetime "track_updated_at"
  end

  add_index "tours", ["group_id"], :name => "index_tours_on_group_id"
  add_index "tours", ["id"], :name => "index_tours_on_id"
  add_index "tours", ["user_id"], :name => "index_tours_on_user_id"

  create_table "tours_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "tour_id"
  end

  add_index "tours_users", ["tour_id"], :name => "index_tours_users_on_tour_id"
  add_index "tours_users", ["user_id"], :name => "index_tours_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "phone"
    t.string   "mail"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "notification_allowed", :default => false
    t.integer  "preferred_group"
    t.boolean  "is_admin",             :default => false, :null => false
    t.datetime "last_login"
  end

  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["mail"], :name => "index_users_on_mail"
  add_index "users", ["preferred_group"], :name => "index_users_on_preferred_group"

end
