class RemoveVenueIdFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :venue_id
  end
end
