# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

%w[s m l].map do |size|
  Property.find_or_create_by!(key: "size", value: size)
end

%w[red green blue].map do |colour|
  Property.find_or_create_by!(key: "colour", value: colour)
end

Property.where(key: "colour").each do |colour_prop|
  name = "#{colour_prop.value.titlecase} t-shirt"
  listing = Listing.find_or_create_by!(name:)
  listing.products.destroy_all

  Property.where(key: "size").each do |size_prop|
    product = listing.products.create!(
      inventory: [0,5,10].sample,
      price_cents_usd: rand(20..25) * 100
    )

    product.product_properties.create!(property: colour_prop)
    product.product_properties.create!(property: size_prop)
  end
end
