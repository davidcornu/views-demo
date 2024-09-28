# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  inventory       :bigint           default(0), not null
#  price_cents_usd :bigint           default(0), not null
#  listing_id      :bigint           not null
#
# Indexes
#
#  index_products_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#
class Product < ApplicationRecord
  belongs_to :listing
  has_many :product_properties
  has_many :properties, through: :product_properties
end
