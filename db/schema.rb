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

ActiveRecord::Schema[7.2].define(version: 2024_09_30_203847) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.text "name", null: false
  end

  create_table "product_properties", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "property_id", null: false
    t.index ["product_id", "property_id"], name: "index_product_properties_on_product_id_and_property_id", unique: true
    t.index ["product_id"], name: "index_product_properties_on_product_id"
    t.index ["property_id"], name: "index_product_properties_on_property_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "listing_id", null: false
    t.bigint "inventory", default: 0, null: false
    t.bigint "price_cents_usd", default: 0, null: false
    t.index ["listing_id"], name: "index_products_on_listing_id"
  end

  create_table "properties", force: :cascade do |t|
    t.text "key", null: false
    t.text "value", null: false
    t.index ["key", "value"], name: "index_properties_on_key_and_value", unique: true
  end

  add_foreign_key "product_properties", "products"
  add_foreign_key "product_properties", "properties"
  add_foreign_key "products", "listings"

  create_view "listing_search_results", materialized: true, sql_definition: <<-SQL
      WITH listing_properties AS (
           SELECT products.listing_id,
              array_agg(DISTINCT product_properties.property_id) AS property_ids
             FROM (product_properties
               JOIN products ON ((product_properties.product_id = products.id)))
            GROUP BY products.listing_id
          ), listing_inventory_and_pricing AS (
           SELECT products.listing_id,
              sum(products.inventory) AS inventory,
              min(products.price_cents_usd) AS min_price_cents_usd,
              max(products.price_cents_usd) AS max_price_cents_usd
             FROM products
            GROUP BY products.listing_id
          )
   SELECT listings.id AS listing_id,
      listings.name AS listing_name,
      listing_properties.property_ids,
      (listing_inventory_and_pricing.inventory > (0)::numeric) AS in_stock,
      listing_inventory_and_pricing.min_price_cents_usd,
      listing_inventory_and_pricing.max_price_cents_usd
     FROM ((listings
       LEFT JOIN listing_properties ON ((listing_properties.listing_id = listings.id)))
       LEFT JOIN listing_inventory_and_pricing ON ((listing_inventory_and_pricing.listing_id = listings.id)));
  SQL
  add_index "listing_search_results", ["listing_id"], name: "index_listing_search_results_on_listing_id", unique: true
  add_index "listing_search_results", ["property_ids"], name: "index_listing_search_results_on_property_ids", using: :gin

end
