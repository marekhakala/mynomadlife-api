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

ActiveRecord::Schema.define(version: 20170109074131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.integer  "data_id",                null: false
    t.string   "slug"
    t.string   "region"
    t.string   "country"
    t.integer  "temperature_c"
    t.integer  "temperature_f"
    t.integer  "humidity"
    t.integer  "rank"
    t.decimal  "cost_per_month"
    t.integer  "internet_speed"
    t.decimal  "population"
    t.string   "gender_ratio"
    t.string   "religious"
    t.string   "city_currency"
    t.string   "image"
    t.integer  "city_score_id"
    t.integer  "city_cost_of_living_id"
    t.integer  "ecb_exchange_rate_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["city_cost_of_living_id"], name: "index_cities_on_city_cost_of_living_id", using: :btree
    t.index ["city_score_id"], name: "index_cities_on_city_score_id", using: :btree
    t.index ["country"], name: "index_cities_on_country", using: :btree
    t.index ["ecb_exchange_rate_id"], name: "index_cities_on_ecb_exchange_rate_id", using: :btree
    t.index ["region"], name: "index_cities_on_region", using: :btree
    t.index ["slug"], name: "index_cities_on_slug", using: :btree
  end

  create_table "city_cost_of_livings", force: :cascade do |t|
    t.decimal  "nomad_cost"
    t.decimal  "expat_cost_of_living"
    t.decimal  "local_cost_of_living"
    t.decimal  "one_bedroom_apartment"
    t.decimal  "hotel_room"
    t.decimal  "airbnb_apartment_month"
    t.decimal  "airbnb_apartment_day"
    t.decimal  "coworking_space"
    t.decimal  "coca_cola_in_cafe"
    t.decimal  "pint_of_beer_in_bar"
    t.decimal  "cappucino_in_cafe"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "city_coworking_places", force: :cascade do |t|
    t.string   "slug"
    t.string   "name"
    t.string   "sub_name"
    t.string   "coworking_type"
    t.string   "distance"
    t.string   "lat"
    t.string   "lng"
    t.string   "data_url"
    t.string   "image_url"
    t.integer  "city_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["city_id"], name: "index_city_coworking_places_on_city_id", using: :btree
  end

  create_table "city_scores", force: :cascade do |t|
    t.decimal  "nomad_score"
    t.decimal  "life_score"
    t.integer  "cost"
    t.integer  "internet"
    t.integer  "fun"
    t.integer  "safety"
    t.integer  "peace"
    t.integer  "nightlife"
    t.integer  "free_wifi_in_city"
    t.integer  "places_to_work"
    t.integer  "ac_or_heating"
    t.integer  "friendly_to_foreigners"
    t.integer  "female_friendly"
    t.integer  "gay_friendly"
    t.decimal  "startup_score"
    t.integer  "english_speaking"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ecb_exchange_rates", force: :cascade do |t|
    t.string   "base"
    t.date     "update_date"
    t.string   "currency_code"
    t.decimal  "currency_rate"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["currency_code"], name: "index_ecb_exchange_rates_on_currency_code", using: :btree
  end

  add_foreign_key "cities", "city_cost_of_livings"
  add_foreign_key "cities", "city_scores"
  add_foreign_key "cities", "ecb_exchange_rates"
  add_foreign_key "city_coworking_places", "cities"
end
