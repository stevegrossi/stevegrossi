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

ActiveRecord::Schema.define(:version => 20120517213321) do

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.string   "pub_year"
    t.string   "asin"
    t.text     "thoughts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
    t.string   "cover_image"
    t.string   "publish_status", :default => "published"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlist_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.string   "purchase_at"
    t.boolean  "purchased",                                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "image_url"
  end

  create_table "works", :force => true do |t|
    t.string   "title"
    t.text     "about"
    t.string   "url"
    t.string   "client"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_filename"
  end

  create_table "writings", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "publish_status", :default => "published"
  end

end
