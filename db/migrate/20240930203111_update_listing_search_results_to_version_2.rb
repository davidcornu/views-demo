class UpdateListingSearchResultsToVersion2 < ActiveRecord::Migration[7.2]
  def change
    update_view :listing_search_results, version: 2, revert_to_version: 1
  end
end
