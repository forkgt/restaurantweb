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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141212084332) do

  create_table "addresses", force: true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type"

  create_table "admins", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "image"
  end

  add_index "admins", ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true

  create_table "cart_items", force: true do |t|
    t.string   "name"
    t.string   "note"
    t.decimal  "price",              precision: 8, scale: 2
    t.integer  "quantity",                                   default: 1
    t.integer  "cart_id"
    t.integer  "cart_itemable_id"
    t.string   "cart_itemable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id"
  add_index "cart_items", ["cart_itemable_id", "cart_itemable_type"], name: "index_cart_items_on_cart_itemable_id_and_cart_itemable_type"

  create_table "cartridges", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.decimal  "price",      precision: 8, scale: 2, default: 0.0
    t.integer  "interval",                           default: 12
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", force: true do |t|
    t.string   "delivery_type",                            default: "delivery", null: false
    t.decimal  "delivery_fee",     precision: 8, scale: 2, default: 0.0
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "delivery_minimum", precision: 8, scale: 2, default: 0.0
  end

  add_index "carts", ["store_id"], name: "index_carts_on_store_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["menu_id"], name: "index_categories_on_menu_id"

  create_table "coupons", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.decimal  "price",      precision: 8, scale: 2
    t.decimal  "minimum",    precision: 8, scale: 2, default: 0.0
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["store_id"], name: "index_coupons_on_store_id"

  create_table "delivery_rules", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.decimal  "delivery_fee",     precision: 8, scale: 2, default: 0.0
    t.decimal  "delivery_minimum", precision: 8, scale: 2, default: 0.0
    t.float    "delivery_radius"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_rules", ["store_id"], name: "index_delivery_rules_on_store_id"

  create_table "dish_choices", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.string   "content",    default: "abc:0,def:1"
    t.string   "input_type", default: "radio"
    t.boolean  "must",       default: false
    t.integer  "store_id"
    t.integer  "checked",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dish_choices", ["store_id"], name: "index_dish_choices_on_store_id"

  create_table "dish_choices_dishes", id: false, force: true do |t|
    t.integer "dish_choice_id", null: false
    t.integer "dish_id",        null: false
  end

  add_index "dish_choices_dishes", ["dish_choice_id", "dish_id"], name: "index_dish_choices_dishes_on_dish_choice_id_and_dish_id"
  add_index "dish_choices_dishes", ["dish_id", "dish_choice_id"], name: "index_dish_choices_dishes_on_dish_id_and_dish_choice_id"

  create_table "dish_features", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dish_features", ["store_id"], name: "index_dish_features_on_store_id"

  create_table "dish_features_dishes", id: false, force: true do |t|
    t.integer "dish_feature_id", null: false
    t.integer "dish_id",         null: false
  end

  add_index "dish_features_dishes", ["dish_feature_id", "dish_id"], name: "index_dish_features_dishes_on_dish_feature_id_and_dish_id"
  add_index "dish_features_dishes", ["dish_id", "dish_feature_id"], name: "index_dish_features_dishes_on_dish_id_and_dish_feature_id"

  create_table "dishes", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.decimal  "price",       precision: 8, scale: 2
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dishes", ["category_id"], name: "index_dishes_on_category_id"

  create_table "hours", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.string   "open_at"
    t.string   "close_at"
    t.integer  "hourable_id"
    t.string   "hourable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hours", ["hourable_id", "hourable_type"], name: "index_hours_on_hourable_id_and_hourable_type"

  create_table "menus", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["store_id"], name: "index_menus_on_store_id"

  create_table "orders", force: true do |t|
    t.string   "note"
    t.string   "invoice"
    t.string   "payment_type",                            default: "cash",     null: false
    t.string   "payment_status",                          default: "not_paid", null: false
    t.string   "transfer_status"
    t.decimal  "tip",             precision: 8, scale: 2, default: 0.0
    t.integer  "store_id"
    t.integer  "cart_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["cart_id"], name: "index_orders_on_cart_id"
  add_index "orders", ["store_id"], name: "index_orders_on_store_id"
  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "payments", force: true do |t|
    t.string   "name"
    t.integer  "rank"
    t.string   "bei"
    t.string   "image"
    t.string   "account"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["store_id"], name: "index_payments_on_store_id"

  create_table "statement_items", force: true do |t|
    t.integer  "day"
    t.string   "name"
    t.string   "note"
    t.decimal  "price",        precision: 8, scale: 2, default: 0.0
    t.integer  "quantity"
    t.integer  "statement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statement_items", ["statement_id"], name: "index_statement_items_on_statement_id"

  create_table "statements", force: true do |t|
    t.integer  "year"
    t.integer  "month"
    t.string   "payment_type"
    t.string   "payment_status"
    t.string   "invoice"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statements", ["store_id"], name: "index_statements_on_store_id"

  create_table "stores", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.integer  "rank"
    t.string   "image"
    t.string   "domain"
    t.string   "phone"
    t.string   "fax"
    t.string   "status",     default: "normal"
    t.string   "uuid"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "has_fax",    default: false,    null: false
    t.string   "fax_usr"
    t.string   "fax_pwd"
  end

  add_index "stores", ["admin_id"], name: "index_stores_on_admin_id"

  create_table "subscriptions", force: true do |t|
    t.integer  "store_id"
    t.integer  "subscribable_id"
    t.string   "subscribable_type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["store_id"], name: "index_subscriptions_on_store_id"
  add_index "subscriptions", ["subscribable_id", "subscribable_type"], name: "index_subscriptions_on_subscribable_id_and_subscribable_type"

  create_table "templates", force: true do |t|
    t.string   "name"
    t.string   "bei"
    t.string   "framework"
    t.integer  "rank"
    t.string   "image"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "interval",                           default: 12
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "image"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
