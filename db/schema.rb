# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100208005903) do

  create_table "calory_lines", :force => true do |t|
    t.integer  "day_id"
    t.integer  "product_id"
    t.integer  "net_weight"
    t.float    "energy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", :force => true do |t|
    t.date     "enter_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "weight",     :precision => 5, :scale => 1
  end

  create_table "products", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.float    "water"
    t.float    "protein"
    t.float    "fat"
    t.float    "carbohydrate"
    t.integer  "energy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",            :null => false
    t.string   "email",               :null => false
    t.string   "crypted_password",    :null => false
    t.string   "password_salt",       :null => false
    t.string   "persistence_token",   :null => false
    t.string   "single_access_token", :null => false
    t.string   "perishable_token",    :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.integer  "height"
    t.date     "born"
    t.boolean  "female"
  end

end
