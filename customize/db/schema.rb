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

ActiveRecord::Schema.define(:version => 20150113093812) do

  create_table "customs", :force => true do |t|
    t.integer  "order_id",   :null => false
    t.integer  "dish_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customs", ["dish_id"], :name => "index_customs_on_dish_id"
  add_index "customs", ["order_id"], :name => "index_customs_on_order_id"

  create_table "dish_images", :force => true do |t|
    t.integer  "dish_id",      :null => false
    t.binary   "data"
    t.string   "content_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "dish_images", ["dish_id"], :name => "index_dish_images_on_dish_id"

  create_table "dishes", :force => true do |t|
    t.string   "name",                         :null => false
    t.integer  "kcal",                         :null => false
    t.integer  "yen",                          :null => false
    t.string   "genra"
    t.string   "category"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "visible",    :default => true
  end

  create_table "foodstuffs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lunchboxes", :force => true do |t|
    t.string   "size"
    t.float    "capacity"
    t.string   "explanation"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "login_id"
    t.string   "password"
    t.string   "name"
    t.string   "tel"
    t.string   "email"
    t.boolean  "admin",           :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "hashed_password"
  end

  create_table "orders", :force => true do |t|
    t.date     "order_date"
    t.integer  "member_id"
    t.datetime "receive_date", :null => false
    t.integer  "lunchbox_id",  :null => false
    t.integer  "staple_id",    :null => false
    t.integer  "main_id",      :null => false
    t.integer  "sub_id",       :null => false
    t.integer  "num"
    t.string   "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "recipes", :force => true do |t|
    t.integer  "dish_id",      :null => false
    t.integer  "foodstuff_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "recipes", ["dish_id"], :name => "index_recipes_on_dish_id"
  add_index "recipes", ["foodstuff_id"], :name => "index_recipes_on_foodstuff_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stocks", :force => true do |t|
    t.integer  "dish_id",    :null => false
    t.string   "date"
    t.float    "stock"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "stocks", ["dish_id"], :name => "index_stocks_on_dish_id"

end
