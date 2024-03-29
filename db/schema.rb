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

ActiveRecord::Schema.define(version: 20170713014525) do

  create_table "blog_users", force: :cascade do |t|
    t.integer  "action",            default: 0
    t.integer  "user_id"
    t.integer  "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_blog_users_on_blog_id"
    t.index ["user_id"], name: "index_blog_users_on_user_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "published",         default: 0
    t.integer  "promoted",          default: 0
    t.datetime "publish"
    t.string   "image"
    t.string   "author_name",       default: "ナルフォード"
    t.string   "author_position",   default: "塾講師"
    t.integer  "author_age",        default: 26
    t.string   "author_avatar"
    t.integer  "biglikes_count",    default: 0
    t.integer  "likes_count",       default: 0
    t.integer  "dislikes_count",    default: 0
    t.integer  "bigdislikes_count", default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "category"
    t.index ["title"], name: "index_blogs_on_title"
    t.index ["published"], name: "index_blogs_on_published"
    t.index ["promoted"], name: "index_blogs_on_promoted"
    t.index ["created_at"], name: "index_blogs_on_created_at"
    t.index ["category"], name: "index_blogs_on_category"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "blog_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_comments_on_blog_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "role",                   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
