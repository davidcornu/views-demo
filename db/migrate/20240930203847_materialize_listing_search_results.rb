class MaterializeListingSearchResults < ActiveRecord::Migration[7.2]
  def up
    drop_view(:listing_search_results)
    create_view(:listing_search_results, version: 2, materialized: true)
    add_index(:listing_search_results, :listing_id, unique: true)
    add_index(:listing_search_results, :property_ids, using: :gin)
  end

  def down
    drop_view(:listing_search_results, materialized: true)
    create_view(:listing_search_results, version: 2)
  end
end
