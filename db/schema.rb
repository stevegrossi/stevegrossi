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

ActiveRecord::Schema.define(:version => 20121028192733) do

  create_table "authors", :force => true do |t|
    t.string   "fname"
    t.string   "mname"
    t.string   "lname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "authors", ["slug"], :name => "index_authors_on_slug", :unique => true

  create_table "authorships", :force => true do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.text     "thesis"
    t.datetime "published_at"
    t.string   "slug"
  end

  add_index "books", ["slug"], :name => "index_books_on_slug", :unique => true

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
    t.string "slug"
  end

  add_index "tags", ["slug"], :name => "index_tags_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", :force => true do |t|
    t.string   "title"
    t.text     "about"
    t.string   "url"
    t.string   "client"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_filename"
    t.datetime "published_at"
    t.string   "slug"
  end

  add_index "works", ["slug"], :name => "index_works_on_slug", :unique => true

  create_table "writings", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "slug"
  end

  add_index "writings", ["slug"], :name => "index_writings_on_slug", :unique => true

end
