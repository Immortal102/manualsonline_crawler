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

ActiveRecord::Schema.define(version: 20180222090803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.string "manualsonline_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name"
  end

  create_table "brands_categories", force: :cascade do |t|
    t.integer "brand_id", null: false
    t.integer "category_id", null: false
    t.string "manualsonline_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id", "category_id"], name: "index_brands_categories_on_brand_id_and_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "manualsonline_subdomain"
    t.string "manualsonline_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "manualsonline_subdomain"], name: "index_categories_on_name_and_manualsonline_subdomain"
  end

  create_table "products", force: :cascade do |t|
    t.integer "brands_category_id"
    t.string "raw_name"
    t.string "name"
    t.string "manualsonline_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brands_category_id", "name", "raw_name"], name: "index_products_on_brands_category_id_and_name_and_raw_name"
  end

end
