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

ActiveRecord::Schema.define(version: 2020_03_19_141105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "kitchens", force: :cascade do |t|
    t.string "item_name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "sku_no"
    t.string "category"
    t.string "barcode"
    t.integer "quantity"
    t.float "base_price"
    t.float "sale_price"
    t.float "gst_percentage"
    t.float "cost"
    t.string "hsn_code"
    t.bigint "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_id"], name: "index_products_on_vendor_id"
  end

  create_table "purchased_items", force: :cascade do |t|
    t.string "item_name"
    t.float "item_price"
    t.string "item_barcode"
    t.string "purchased_from"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.string "mode_of_payment"
  end

  create_table "purchased_sold_items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "quantity"
    t.string "barcode"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_value"
    t.string "mode_of_payment"
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vendor_id"
    t.float "total_price"
    t.index ["vendor_id"], name: "index_sales_on_vendor_id"
  end

  create_table "sold_products", force: :cascade do |t|
    t.integer "quantity"
    t.float "sold_amount"
    t.string "gst"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "vendor_id"
    t.float "tax_percentage"
    t.float "vendor_amount"
    t.float "tax_amount"
    t.index ["product_id"], name: "index_sold_products_on_product_id"
    t.index ["vendor_id"], name: "index_sold_products_on_vendor_id"
  end

  create_table "vendor_amounts", force: :cascade do |t|
    t.integer "quantity"
    t.float "sold_amount"
    t.string "gst"
    t.float "tax_percentage"
    t.float "vendor_amount"
    t.float "tax_amount"
    t.bigint "product_id"
    t.bigint "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_vendor_amounts_on_product_id"
    t.index ["vendor_id"], name: "index_vendor_amounts_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gstin"
  end

  add_foreign_key "products", "vendors"
  add_foreign_key "sales", "vendors"
  add_foreign_key "sold_products", "products"
  add_foreign_key "sold_products", "vendors"
  add_foreign_key "vendor_amounts", "products"
  add_foreign_key "vendor_amounts", "vendors"
end
