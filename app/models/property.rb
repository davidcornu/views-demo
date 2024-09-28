# == Schema Information
#
# Table name: properties
#
#  id    :bigint           not null, primary key
#  key   :text             not null
#  value :text             not null
#
# Indexes
#
#  index_properties_on_key_and_value  (key,value) UNIQUE
#
class Property < ApplicationRecord
  has_many :product_properties
  has_many :products, through: :product_properties
end
