# == Schema Information
#
# Table name: listings
#
#  id   :bigint           not null, primary key
#  name :text             not null
#
class Listing < ApplicationRecord
  has_many :products

  def self.overview
    grouped_properties = ProductProperty
      .joins(:property)
      .group(:product_id)
      .select(
        :product_id,
        Arel.sql("json_agg(json_build_array(key, value)) as properties")
      )

    Listing
      .with(grouped_properties:)
      .joins(:products)
      .joins(<<~SQL)
          left outer join grouped_properties 
          on grouped_properties.product_id = products.id
      SQL
      .pluck(
        "listings.id",
        "listings.name",
        "products.id",
        "products.inventory",
        "products.price_cents_usd",
        "grouped_properties.properties",
      )
  end
end
