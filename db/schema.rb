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

ActiveRecord::Schema.define(version: 20210522134611) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "",                    null: false
    t.string   "encrypted_password",     default: "",                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",             default: '2021-05-22 13:55:28'
    t.datetime "updated_at",             default: '2021-05-22 13:55:28'
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
    t.index ["room_id"], name: "index_entries_on_room_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "follow_relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "created_at",   default: '2021-05-22 14:00:03'
    t.datetime "updated_at",   default: '2021-05-22 14:00:03'
    t.index ["follower_id", "following_id"], name: "index_follow_relationships_on_follower_id_and_following_id", unique: true
    t.index ["follower_id"], name: "index_follow_relationships_on_follower_id"
    t.index ["following_id"], name: "index_follow_relationships_on_following_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", default: '2021-05-22 13:55:28'
    t.datetime "updated_at", default: '2021-05-22 13:55:28'
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "post_items", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "item"
    t.string   "post_item_image"
    t.string   "place"
    t.text     "introduction"
    t.datetime "created_at",      default: '2021-05-22 13:55:28'
    t.datetime "updated_at",      default: '2021-05-22 13:55:28'
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "title"
    t.string   "post_image"
    t.string   "tag"
    t.text     "introduction"
    t.integer  "price"
    t.integer  "genre_name",   default: 0
    t.datetime "created_at",   default: '2021-05-22 13:55:28'
    t.datetime "updated_at",   default: '2021-05-22 13:55:28'
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "instagram_id"
    t.string   "name"
    t.text     "introduction"
    t.string   "profile_image"
    t.datetime "created_at",    default: '2021-05-22 13:55:28'
    t.datetime "updated_at",    default: '2021-05-22 13:55:28'
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "tag_maps", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
    t.index ["post_id"], name: "index_tag_maps_on_post_id"
    t.index ["tag_id"], name: "index_tag_maps_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name"
    t.datetime "created_at", default: '2021-05-22 14:00:03'
    t.datetime "updated_at", default: '2021-05-22 14:00:03'
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                default: "",                    null: false
    t.string   "encrypted_password",   default: "",                    null: false
    t.string   "reset_password_token"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "first_name_kana"
    t.string   "last_name_kana"
    t.string   "phone_number"
    t.boolean  "is_active",            default: true
    t.datetime "created_at",           default: '2021-05-22 13:55:28'
    t.datetime "updated_at",           default: '2021-05-22 13:55:28'
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
