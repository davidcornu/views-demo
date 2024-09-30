class CreateListingSearchResults < ActiveRecord::Migration[7.2]
  def change
    create_view :listing_search_results
  end
end
