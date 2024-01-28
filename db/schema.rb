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

ActiveRecord::Schema[7.0].define(version: 2024_01_25_210344) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "blog_type"
    t.string "pinned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "brand_tag_assocs", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brand_tag_assocs_on_brand_id"
    t.index ["tag_id"], name: "index_brand_tag_assocs_on_tag_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.integer "views", default: 0
    t.bigint "user_id", null: false
    t.string "link"
    t.string "brand_color", default: "0"
    t.string "brand_text", default: "#654321;"
    t.text "header"
    t.string "ig_link"
    t.string "last_edited"
    t.string "verification"
    t.string "location"
    t.string "x_twitter"
    t.string "concept"
    t.string "start_up"
    t.string "slug"
    t.string "badge"
    t.text "metadesc"
    t.string "collab"
    t.string "influencer"
    t.string "apparel"
    t.integer "influencer_rating"
    t.integer "apparel_rating"
    t.string "tiktok"
    t.index ["slug"], name: "index_brands_on_slug", unique: true
    t.index ["user_id"], name: "index_brands_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subcats"
  end

  create_table "closets", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_closets_on_post_id"
    t.index ["user_id"], name: "index_closets_on_user_id"
  end

  create_table "collectibles", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "collection_id", null: false
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
    t.bigint "commentable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favoritables", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favoritables_on_post_id"
    t.index ["user_id"], name: "index_favoritables_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "likeables", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "likeable_type"
    t.index ["likeable_id"], name: "index_likeables_on_likeable_id"
    t.index ["user_id"], name: "index_likeables_on_user_id"
  end

  create_table "pagelinks", force: :cascade do |t|
    t.string "web_link"
    t.text "body"
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price"
    t.index ["post_id"], name: "index_pagelinks_on_post_id"
    t.index ["user_id"], name: "index_pagelinks_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.float "price"
    t.string "color"
    t.string "sub_category"
    t.string "web_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "views", default: 0
    t.string "c_type", default: "neutral"
    t.string "material"
    t.text "amazon_link"
    t.string "edited_by"
    t.bigint "brand_id"
    t.string "archive"
    t.text "grailed"
    t.bigint "category_id"
    t.string "slug"
    t.string "season"
    t.index ["brand_id"], name: "index_posts_on_brand_id"
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "styleables", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "style_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_styleables_on_brand_id"
    t.index ["style_id"], name: "index_styleables_on_style_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggables", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.bigint "tag_id", null: false
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
    t.string "text_color", default: "#654321;"
    t.integer "role", default: 0
    t.string "link1_title"
    t.string "link2_title"
    t.text "description"
    t.datetime "locked_at"
    t.integer "failed_attempts"
    t.string "unlock_token"
    t.string "slug"
    t.integer "sign_in_count", default: 0, null: false
    t.integer "onboard", default: 0
    t.integer "coins", default: 10
    t.integer "tokens", default: 1
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blogs", "users"
  add_foreign_key "brand_tag_assocs", "brands"
  add_foreign_key "brand_tag_assocs", "tags"
  add_foreign_key "brands", "users"
  add_foreign_key "closets", "posts"
  add_foreign_key "closets", "users"
  add_foreign_key "collectibles", "collections"
  add_foreign_key "collectibles", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "favoritables", "posts"
  add_foreign_key "favoritables", "users"
  add_foreign_key "likeables", "posts", column: "likeable_id"
  add_foreign_key "likeables", "users"
  add_foreign_key "pagelinks", "posts"
  add_foreign_key "pagelinks", "users"
  add_foreign_key "posts", "brands"
  add_foreign_key "posts", "categories"
  add_foreign_key "posts", "users"
  add_foreign_key "styleables", "brands"
  add_foreign_key "styleables", "styles"
  add_foreign_key "taggables", "posts"
  add_foreign_key "taggables", "tags"
end
