# == Schema Information
#
# Table name: product_properties
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  property_id :bigint           not null
#
# Indexes
#
#  index_product_properties_on_product_id                  (product_id)
#  index_product_properties_on_product_id_and_property_id  (product_id,property_id) UNIQUE
#  index_product_properties_on_property_id                 (property_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (property_id => properties.id)
#
class ProductProperty < ApplicationRecord
  belongs_to :product
  belongs_to :property
end
