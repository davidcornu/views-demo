# == Schema Information
#
# Table name: listings
#
#  id   :bigint           not null, primary key
#  name :text             not null
#
class Listing < ApplicationRecord
  has_many :products
end
