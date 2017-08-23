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

ActiveRecord::Schema.define(version: 20170822103042) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
    t.integer  "order"
  end

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.float    "price"
    t.string   "tags"
    t.string   "picture"
    t.integer  "gluten_free",    default: 0
    t.integer  "crustacea_free", default: 0
    t.integer  "egg_free",       default: 0
    t.integer  "fish_free",      default: 0
    t.integer  "peanut_free",    default: 0
    t.integer  "lactose_free",   default: 0
    t.integer  "nut_free",       default: 0
    t.integer  "sulphite_free",  default: 0
    t.string   "slug"
    t.integer  "order"
    t.boolean  "activate",       default: true
    t.index ["slug"], name: "index_dishes_on_slug", unique: true
  end

  create_table "dishes_menus", id: false, force: :cascade do |t|
    t.integer "dish_id", null: false
    t.integer "menu_id", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "logo"
    t.integer  "restaurant_id"
    t.integer  "order"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "content"
    t.string   "tags"
    t.float    "price"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "picture"
    t.string   "slug"
    t.integer  "order"
    t.boolean  "activate",      default: true
    t.integer  "root_menu_id"
    t.index ["slug"], name: "index_menus_on_slug", unique: true
  end

  create_table "newsletters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "website"
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.integer  "day"
    t.time     "closes"
    t.time     "opens"
    t.datetime "valid_from"
    t.datetime "valid_through"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "payements", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "transaction_id"
    t.integer  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "product_id"
    t.text     "notification_params"
    t.datetime "purchased_at"
    t.string   "mc_gross"
    t.string   "protection_eligibility"
    t.string   "address_status"
    t.string   "payer_id"
    t.string   "address_street"
    t.string   "payment_date"
    t.string   "payment_status"
    t.string   "address_zip"
    t.string   "first_name"
    t.string   "address_country_code"
    t.string   "address_name"
    t.string   "notify_version"
    t.string   "custom"
    t.string   "payer_status"
    t.string   "business"
    t.string   "address_country"
    t.string   "address_city"
    t.string   "quantity"
    t.string   "verify_sign"
    t.string   "payer_email"
    t.string   "txn_id"
    t.string   "payment_type"
    t.string   "last_name"
    t.string   "address_state"
    t.string   "receiver_email"
    t.string   "receiver_id"
    t.string   "pending_reason"
    t.string   "txn_type"
    t.string   "item_name"
    t.string   "mc_currency"
    t.string   "item_number"
    t.string   "residence_country"
    t.string   "test_ipn"
    t.string   "transaction_subject"
    t.string   "payment_gross"
    t.string   "ipn_track_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "tags"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "picture"
    t.string   "slug"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "months"
    t.float    "price"
    t.boolean  "activate",   default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "zip_code"
    t.string   "city"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "module_blog",         default: false
    t.string   "logo"
    t.string   "picture"
    t.boolean  "module_allergens",    default: false
    t.string   "slug"
    t.string   "css"
    t.integer  "picture_display",     default: 2
    t.boolean  "module_contact",      default: true
    t.boolean  "module_menus",        default: true
    t.string   "plain_opening_hours"
    t.boolean  "module_dishes",       default: true
    t.string   "phone"
    t.string   "email"
    t.index ["slug"], name: "index_restaurants_on_slug", unique: true
  end

  create_table "resumes", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "picture"
    t.integer  "order"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "login_count",            default: 0,     null: false
    t.integer  "failed_login_count",     default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "picture"
    t.string   "slug"
    t.boolean  "premium",                default: false
    t.datetime "premium_until"
    t.string   "new_email"
    t.string   "email_token"
    t.datetime "email_token_updated_at"
    t.boolean  "activated",              default: false, null: false
    t.string   "perishable_token",       default: "",    null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["perishable_token"], name: "index_users_on_perishable_token"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

end
