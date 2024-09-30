# == Schema Information
#
# Table name: listing_search_results
#
#  in_stock     :boolean
#  listing_name :text
#  property_ids :bigint           is an Array
#  listing_id   :bigint
#
class ListingSearchResult < ApplicationRecord
  belongs_to :listing

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
