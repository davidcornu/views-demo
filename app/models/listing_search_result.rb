# == Schema Information
#
# Table name: listing_search_results
#
#  in_stock            :boolean
#  listing_name        :text
#  max_price_cents_usd :bigint
#  min_price_cents_usd :bigint
#  property_ids        :bigint           is an Array
#  listing_id          :bigint
#
# Indexes
#
#  index_listing_search_results_on_listing_id    (listing_id) UNIQUE
#  index_listing_search_results_on_property_ids  (property_ids) USING gin
#
class ListingSearchResult < ApplicationRecord
  belongs_to :listing

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: true, cascade: false)
  end

  # Optional: Mark this record as read-only so we fail fast if we attempt writes
  def readonly?
    true
  end

  def self.in_stock
    where(in_stock: true)
  end

  def self.with_property(property)
    where("? = any(property_ids)", property.id)
  end
end
