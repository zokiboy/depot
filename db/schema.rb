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

ActiveRecord::Schema.define(:version => 20080727113810) do

  create_table "line_items", :force => true do |t|
    t.integer "product_id",  :limit => 11,                               :null => false
    t.integer "order_id",    :limit => 11,                               :null => false
    t.integer "quantity",    :limit => 11,                               :null => false
    t.decimal "total_price",               :precision => 8, :scale => 2, :null => false
  end

  add_index "line_items", ["product_id"], :name => "fk_line_item_products"
  add_index "line_items", ["order_id"], :name => "fk_line_item_orders"

  create_table "orders", :force => true do |t|
    t.string  "name"
    t.text    "address"
    t.string  "email"
    t.integer "payment_type_id", :limit => 11, :null => false
  end

  add_index "orders", ["payment_type_id"], :name => "fk_order_payment_types"

  create_table "payment_types", :force => true do |t|
    t.string "label", :default => "", :null => false
    t.string "value", :default => "", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
