# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_10_210636) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "blog_type"
    t.string "pinned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.integer "views", default: 0
    t.integer "user_id", null: false
    t.string "link"
    t.string "brand_color", default: "0"
    t.string "brand_text", default: "0"
    t.text "header"
    t.string "ig_link"
    t.string "last_edited"
    t.index ["user_id"], name: "index_brands_on_user_id"
  end

  create_table "closets", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_closets_on_post_id"
    t.index ["user_id"], name: "index_closets_on_user_id"
  end

  create_table "collectibles", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "collection_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collectibles_on_collection_id"
    t.index ["post_id"], name: "index_collectibles_on_post_id"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "likes", default: 0
    t.integer "views", default: 0
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.string "c_type"
    t.text "link"
    t.string "commentable_type", null: false
    t.integer "commentable_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likeables", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likeables_on_post_id"
    t.index ["user_id"], name: "index_likeables_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.float "price"
    t.string "color"
    t.string "category"
    t.string "sub_category"
    t.string "web_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "views", default: 0
    t.string "c_type"
    t.string "material"
    t.text "amazon_link"
    t.string "edited_by"
    t.integer "brand_id"
    t.index ["brand_id"], name: "index_posts_on_brand_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "taggables", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_taggables_on_post_id"
    t.index ["tag_id"], name: "index_taggables_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "username"
    t.integer "views", default: 0
    t.string "last_name"
    t.text "link1"
    t.text "link2"
    t.string "primary_color", default: "#cbb595;"
    t.string "secondary_color", default: "#654321;"
    t.string "text_color", default: "black"
    t.integer "role", default: 0
    t.string "link1_title"
    t.string "link2_title"
    t.text "description"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blogs", "users"
  add_foreign_key "brands", "users"
  add_foreign_key "closets", "posts"
  add_foreign_key "closets", "users"
  add_foreign_key "collectibles", "collections"
  add_foreign_key "collectibles", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "likeables", "posts"
  add_foreign_key "likeables", "users"
  add_foreign_key "posts", "brands"
  add_foreign_key "posts", "users"
  add_foreign_key "taggables", "posts"
  add_foreign_key "taggables", "tags"
end
