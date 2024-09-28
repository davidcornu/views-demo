class BaseSchema < ActiveRecord::Migration[7.2]
  def change
    create_table :listings do |t|
      t.text :name, null: false
    end

    create_table :products do |t|
      t.references :listing, null: false, foreign_key: true
      t.bigint :inventory, null: false, default: 0
      t.bigint :price_cents_usd, null: false, default: 0
    end

    create_table :properties do |t|
      t.text :key, null: false
      t.text :value, null: false
      t.index [:key, :value], unique: true
    end

    create_table :product_properties do |t|
      t.references :product, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.index [:product_id, :property_id], unique: true
    end
  end
end
